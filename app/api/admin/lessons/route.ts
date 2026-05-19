import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { syncModuleCounts } from "@/lib/admin-module-sync";
import { assertSupabaseConfigured } from "@/lib/assert-supabase";

export async function POST(req: NextRequest) {
  try {
    assertSupabaseConfigured();
    await requireAdminSession();
    const body = await req.json();
    const { module_id, title, content, video_url, duration_min, order_num } = body;

    if (!module_id || !title) {
      return NextResponse.json({ error: "module_id and title required" }, { status: 400 });
    }

    const { data, error } = await supabaseAdmin
      .from("lessons")
      .insert({
        module_id,
        title,
        content: content ?? null,
        video_url: video_url ?? null,
        duration_min: duration_min ?? 0,
        order_num: order_num ?? 1,
      })
      .select()
      .single();

    if (error) throw error;
    await syncModuleCounts(module_id);
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function PUT(req: NextRequest) {
  try {
    assertSupabaseConfigured();
    await requireAdminSession();
    const body = await req.json();
    const { id, module_id, ...updates } = body;

    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const { data, error } = await supabaseAdmin
      .from("lessons")
      .update(updates)
      .eq("id", id)
      .select("*, module_id")
      .single();

    if (error) throw error;
    await syncModuleCounts(module_id ?? data.module_id);
    return NextResponse.json(data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function DELETE(req: NextRequest) {
  try {
    assertSupabaseConfigured();
    await requireAdminSession();
    const { id, module_id } = await req.json();

    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const { error } = await supabaseAdmin.from("lessons").delete().eq("id", id);
    if (error) throw error;

    if (module_id) await syncModuleCounts(module_id);
    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
