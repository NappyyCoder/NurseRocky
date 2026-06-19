import { auth } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { syncEnrollmentForClerkUser } from "@/lib/server/enrollment-link";
import { supabaseAdmin } from "@/lib/supabase";

/** Manually retry linking a paid Stripe checkout to the signed-in student. */
export async function POST() {
  const { userId } = await auth();
  if (!userId) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const sync = await syncEnrollmentForClerkUser(userId);
  if (!sync.ok && sync.reason === "database_unreachable") {
    return NextResponse.json(
      {
        error: sync.error,
        hint: sync.hint,
        dbHealthy: false,
      },
      { status: 503 }
    );
  }

  const studentId = await resolveStudentId(userId);
  if (!studentId) {
    return NextResponse.json(
      {
        error: sync.error ?? "No enrollment found for this account yet.",
        hint:
          sync.hint ??
          "Pay at /enroll with the same email you use to sign in, then try again.",
        dbHealthy: sync.reason !== "database_unreachable",
      },
      { status: 404 }
    );
  }

  const { data: student } = await supabaseAdmin
    .from("students")
    .select("enrolled")
    .eq("id", studentId)
    .single();

  const enrolled = student?.enrolled === true;

  if (!enrolled) {
    return NextResponse.json(
      {
        ok: false,
        enrolled: false,
        error: "Account found but enrollment is not active.",
        hint:
          sync.hint ??
          "Complete payment at /enroll, then link again with the same email.",
        dbHealthy: true,
      },
      { status: 404 }
    );
  }

  return NextResponse.json({
    ok: true,
    enrolled: true,
    dbHealthy: true,
  });
}
