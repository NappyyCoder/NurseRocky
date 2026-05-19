import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";

export async function POST(req: NextRequest) {
  try {
    await requireAdminSession();
    const { quiz_id, question, options, correct_answer, order_num, rationale } = await req.json();

    if (!quiz_id || !question || !Array.isArray(options)) {
      return NextResponse.json(
        { error: "quiz_id, question, and options[] required" },
        { status: 400 }
      );
    }

    const row: Record<string, unknown> = {
      quiz_id,
      question,
      options,
      correct_answer: correct_answer ?? 0,
      order_num: order_num ?? 1,
    };
    if (rationale != null && rationale !== "") {
      row.rationale = rationale;
    }

    let result = await supabaseAdmin.from("quiz_questions").insert(row).select().single();

    if (result.error?.message?.includes("rationale")) {
      delete row.rationale;
      result = await supabaseAdmin.from("quiz_questions").insert(row).select().single();
    }

    if (result.error) throw result.error;
    return NextResponse.json(result.data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function PUT(req: NextRequest) {
  try {
    await requireAdminSession();
    const { id, rationale, ...rest } = await req.json();

    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const updates: Record<string, unknown> = { ...rest };
    if (rationale !== undefined) {
      updates.rationale = rationale || null;
    }

    let result = await supabaseAdmin
      .from("quiz_questions")
      .update(updates)
      .eq("id", id)
      .select()
      .single();

    if (result.error?.message?.includes("rationale")) {
      delete updates.rationale;
      result = await supabaseAdmin
        .from("quiz_questions")
        .update(updates)
        .eq("id", id)
        .select()
        .single();
    }

    if (result.error) throw result.error;
    return NextResponse.json(result.data);
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}

export async function DELETE(req: NextRequest) {
  try {
    await requireAdminSession();
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const { error } = await supabaseAdmin.from("quiz_questions").delete().eq("id", id);
    if (error) throw error;
    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
