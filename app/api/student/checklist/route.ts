import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { resolveStudentId } from "@/lib/server/resolve-student";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const { item_key, completed } = await req.json();
    if (!item_key) return NextResponse.json({ error: "item_key required" }, { status: 400 });

    await supabaseAdmin.from("student_checklist").upsert(
      {
        student_id: studentId,
        item_key,
        completed: completed !== false,
        completed_at: completed !== false ? new Date().toISOString() : null,
      },
      { onConflict: "student_id,item_key" }
    );

    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : "Error" }, { status: 500 });
  }
}
