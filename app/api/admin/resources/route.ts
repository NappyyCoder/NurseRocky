import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";

export async function GET() {
  try {
    await requireAdminSession();
    const { data, error } = await supabaseAdmin
      .from("course_resources")
      .select("*")
      .order("order_num");
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
      .from("course_resources")
      .insert({
        module_id: body.module_id ?? null,
        title: body.title,
        url: body.url,
        resource_type: body.resource_type ?? "link",
        description: body.description ?? null,
        order_num: body.order_num ?? 1,
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
      .from("course_resources")
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

export async function DELETE(req: NextRequest) {
  try {
    await requireAdminSession();
    const { id } = await req.json();
    const { error } = await supabaseAdmin.from("course_resources").delete().eq("id", id);
    if (error) throw error;
    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
