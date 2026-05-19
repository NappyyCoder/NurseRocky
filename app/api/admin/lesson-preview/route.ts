import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { getAugmentedLessonHtml } from "@/lib/course/lesson-html";
import { htmlForModule1Lesson } from "@/lib/course/module1-lesson-bodies";

/** What students see for a lesson + optional curriculum default for admin editor. */
export async function GET(req: NextRequest) {
  try {
    await requireAdminSession();
    const moduleId = Number(req.nextUrl.searchParams.get("moduleId"));
    const orderNum = Number(req.nextUrl.searchParams.get("orderNum"));
    const lessonId = req.nextUrl.searchParams.get("lessonId");

    if (!Number.isFinite(moduleId) || !Number.isFinite(orderNum)) {
      return NextResponse.json({ error: "moduleId and orderNum required" }, { status: 400 });
    }

    let storedContent: string | null = null;
    if (lessonId) {
      const { data } = await supabaseAdmin
        .from("lessons")
        .select("content")
        .eq("id", lessonId)
        .maybeSingle();
      storedContent = data?.content ?? null;
    }

    const liveHtml = getAugmentedLessonHtml(moduleId, orderNum, storedContent);
    const curriculumDefault =
      moduleId === 1 ? htmlForModule1Lesson(orderNum) ?? "" : "";

    const source = (storedContent ?? "").trim()
      ? "database"
      : curriculumDefault.trim()
        ? "curriculum"
        : "empty";

    return NextResponse.json({
      liveHtml,
      curriculumDefault,
      source,
    });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
