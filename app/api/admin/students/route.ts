import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { computeFinishedModuleIds } from "@/lib/server/course-completion";
import { countPassedQuizzes } from "@/lib/server/student-quiz-grades";

export async function GET() {
  try {
    await requireAdminSession();

    const { data: students, error } = await supabaseAdmin
      .from("students")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) throw error;

    const enriched = await Promise.all(
      (students ?? []).map(async (s) => {
        const studentId = s.id as string;
        const [finished, passedQuizzes, { data: clinical }] = await Promise.all([
          computeFinishedModuleIds(studentId),
          countPassedQuizzes(studentId),
          supabaseAdmin.from("clinical_hours").select("hours").eq("student_id", studentId),
        ]);

        const totalClinical = (clinical ?? []).reduce(
          (sum, r) => sum + Number(r.hours),
          0
        );

        return {
          ...s,
          completed_modules: finished.size,
          quizzes_passed: passedQuizzes,
          clinical_hours: totalClinical,
        };
      })
    );

    return NextResponse.json(enriched);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
