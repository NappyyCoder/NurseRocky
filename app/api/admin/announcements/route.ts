import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";

export async function GET() {
  try {
    await requireAdminSession();
    const { data, error } = await supabaseAdmin
      .from("announcements")
      .select("*")
      .order("created_at", { ascending: false });
    if (error) throw error;
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function POST(req: NextRequest) {
  try {
    await requireAdminSession();
    const body = await req.json();
    const { data, error } = await supabaseAdmin
      .from("announcements")
      .insert({
        title: body.title,
        body: body.body,
        is_active: body.is_active ?? true,
        expires_at: body.expires_at ?? null,
      })
      .select()
      .single();
    if (error) throw error;
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function PUT(req: NextRequest) {
  try {
    await requireAdminSession();
    const { id, ...updates } = await req.json();
    const { data, error } = await supabaseAdmin
      .from("announcements")
      .update(updates)
      .eq("id", id)
      .select()
      .single();
    if (error) throw error;
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
