import { auth, currentUser } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { canonicalStudentEmail } from "@/lib/stripe-enrollment";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { lesson_id } = (await req.json()) as { lesson_id?: string };
    if (!lesson_id) {
      return NextResponse.json({ error: "lesson_id required" }, { status: 400 });
    }

    const user = await currentUser();
    const email = canonicalStudentEmail(user?.primaryEmailAddress?.emailAddress ?? "");

    let { data: student } = await supabaseAdmin
      .from("students")
      .select("id, enrolled")
      .eq("clerk_user_id", userId)
      .maybeSingle();

    if (!student && email) {
      const { data: byEmail } = await supabaseAdmin
        .from("students")
        .select("id, enrolled")
        .eq("email", email)
        .is("clerk_user_id", null)
        .maybeSingle();

      if (byEmail?.id) {
        await supabaseAdmin
          .from("students")
          .update({
            clerk_user_id: userId,
            first_name: user?.firstName ?? null,
            last_name: user?.lastName ?? null,
          })
          .eq("id", byEmail.id);
        student = byEmail;
      }
    }

    if (!student?.enrolled) {
      return NextResponse.json({ error: "Enrollment required" }, { status: 403 });
    }

    const { data: lesson, error: le } = await supabaseAdmin
      .from("lessons")
      .select("id, module_id")
      .eq("id", lesson_id)
      .maybeSingle();

    if (le || !lesson) {
      return NextResponse.json({ error: "Lesson not found" }, { status: 404 });
    }

    const { error: upErr } = await supabaseAdmin.from("student_progress").upsert(
      {
        student_id: student.id,
        module_id: lesson.module_id,
        lesson_id: lesson.id,
        completed: true,
        completed_at: new Date().toISOString(),
        last_accessed_at: new Date().toISOString(),
      },
      { onConflict: "student_id,lesson_id" }
    );

    if (upErr) throw upErr;

    await supabaseAdmin
      .from("students")
      .update({ last_lesson_id: lesson.id, last_module_id: lesson.module_id })
      .eq("id", student.id);

    return NextResponse.json({ ok: true });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
