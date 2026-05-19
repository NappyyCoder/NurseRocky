import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { searchStudentContent } from "@/lib/server/student-dashboard";

export async function GET(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const q = req.nextUrl.searchParams.get("q") ?? "";
    const results = await searchStudentContent(q);
    return NextResponse.json(results);
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : "Error" }, { status: 500 });
  }
}
