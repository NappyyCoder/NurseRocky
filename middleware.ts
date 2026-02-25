import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";

const isStudentRoute = createRouteMatcher(["/dashboard(.*)"]);
const isAdminRoute = createRouteMatcher(["/admin/dashboard(.*)"]);

export default clerkMiddleware(async (auth, req) => {
  // Protect student dashboard — must be signed in
  if (isStudentRoute(req)) {
    await auth.protect();
  }

  // Protect admin dashboard — must be signed in AND have admin role
  if (isAdminRoute(req)) {
    const { sessionClaims } = await auth.protect();
    const role = (sessionClaims?.metadata as { role?: string })?.role;
    if (role !== "admin") {
      return NextResponse.redirect(new URL("/admin/sign-in", req.url));
    }
  }
});

export const config = {
  matcher: [
    "/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)",
    "/(api|trpc)(.*)",
  ],
};
