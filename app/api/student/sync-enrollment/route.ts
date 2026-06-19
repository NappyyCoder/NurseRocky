import { auth } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { supabaseAdmin } from "@/lib/supabase";

/** Manually retry linking a paid Stripe checkout to the signed-in student. */
export async function POST() {
  const { userId } = await auth();
  if (!userId) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const studentId = await resolveStudentId(userId);
  if (!studentId) {
    return NextResponse.json(
      { error: "No enrollment found for this account yet." },
      { status: 404 }
    );
  }

  const { data: student } = await supabaseAdmin
    .from("students")
    .select("enrolled")
    .eq("id", studentId)
    .single();

  return NextResponse.json({
    ok: true,
    enrolled: student?.enrolled === true,
  });
}
