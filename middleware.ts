import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { clerkIsAdmin } from "@/lib/clerk-admin";

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
    if (!clerkIsAdmin(sessionClaims)) {
      return NextResponse.redirect(new URL("/admin/sign-in", req.url));
    }
  }
});

/**
 * Clerk must run on every route that calls `auth()` (pages + /api routes). A narrow matcher
 * breaks `/sign-in`, `/enroll/success`, `POST /api/student/*`, `/api/admin/*`, etc.
 * Excludes `_next/static` chunks and usual static file extensions.
 */
export const config = {
  matcher: [
    "/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)",
    "/(api|trpc)(.*)",
  ],
};
