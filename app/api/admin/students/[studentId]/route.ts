import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { getAdminStudentDetail } from "@/lib/server/admin-student-detail";

export async function GET(
  _req: NextRequest,
  ctx: { params: Promise<{ studentId: string }> }
) {
  try {
    await requireAdminSession();
    const { studentId } = await ctx.params;
    const detail = await getAdminStudentDetail(studentId);
    return NextResponse.json(detail);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status: error === "Student not found" ? 404 : status });
  }
}

export async function PUT(
  req: NextRequest,
  ctx: { params: Promise<{ studentId: string }> }
) {
  try {
    await requireAdminSession();
    const { studentId } = await ctx.params;
    const body = await req.json();
    const { enrolled, first_name, last_name } = body as {
      enrolled?: boolean;
      first_name?: string;
      last_name?: string;
    };

    const updates: Record<string, unknown> = {};
    if (typeof enrolled === "boolean") {
      updates.enrolled = enrolled;
      updates.enrolled_at = enrolled ? new Date().toISOString() : null;
    }
    if (first_name !== undefined) updates.first_name = first_name || null;
    if (last_name !== undefined) updates.last_name = last_name || null;

    if (!Object.keys(updates).length) {
      return NextResponse.json({ error: "No updates provided" }, { status: 400 });
    }

    const { data, error } = await supabaseAdmin
      .from("students")
      .update(updates)
      .eq("id", studentId)
      .select()
      .single();

    if (error) throw error;
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
