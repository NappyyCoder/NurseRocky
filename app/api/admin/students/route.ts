import { auth } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";

async function requireAdmin() {
  const { sessionClaims } = await auth();
  const role = (sessionClaims?.metadata as { role?: string })?.role;
  if (role !== "admin") throw new Error("Unauthorized");
}

// GET — list all students with their progress summary
export async function GET() {
  try {
    await requireAdmin();

    const { data: students, error } = await supabaseAdmin
      .from("students")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) throw error;

    // Attach progress counts and clinical hours for each student
    const enriched = await Promise.all(
      (students ?? []).map(async (s) => {
        const [{ count: completedModules }, { data: clinical }] = await Promise.all([
          supabaseAdmin
            .from("student_progress")
            .select("*", { count: "exact", head: true })
            .eq("student_id", s.id)
            .eq("completed", true),
          supabaseAdmin
            .from("clinical_hours")
            .select("hours")
            .eq("student_id", s.id),
        ]);

        const totalClinical = (clinical ?? []).reduce(
          (sum, r) => sum + Number(r.hours), 0
        );

        return {
          ...s,
          completed_modules: completedModules ?? 0,
          clinical_hours: totalClinical,
        };
      })
    );

    return NextResponse.json(enriched);
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: msg === "Unauthorized" ? 401 : 500 });
  }
}
