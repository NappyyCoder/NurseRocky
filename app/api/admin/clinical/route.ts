import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { clerkIsAdmin } from "@/lib/clerk-admin";

async function requireAdmin() {
  const { sessionClaims } = await auth();
  if (!clerkIsAdmin(sessionClaims)) throw new Error("Unauthorized");
}

// POST — log clinical hours for a student
export async function POST(req: NextRequest) {
  try {
    await requireAdmin();
    const body = await req.json();
    const { data, error } = await supabaseAdmin
      .from("clinical_hours")
      .insert({
        student_id: body.student_id,
        hours: body.hours,
        notes: body.notes ?? null,
        date: body.date,
        approved_by: body.approved_by ?? "Admin",
      })
      .select()
      .single();
    if (error) throw error;
    return NextResponse.json(data);
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: msg === "Unauthorized" ? 401 : 500 });
  }
}

// DELETE — remove a clinical hours entry
export async function DELETE(req: NextRequest) {
  try {
    await requireAdmin();
    const { id } = await req.json();
    const { error } = await supabaseAdmin.from("clinical_hours").delete().eq("id", id);
    if (error) throw error;
    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: msg === "Unauthorized" ? 401 : 500 });
  }
}
