import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { clerkIsAdmin } from "@/lib/clerk-admin";

const isStudentRoute = createRouteMatcher(["/dashboard(.*)"]);
const isAdminRoute = createRouteMatcher(["/admin/dashboard(.*)"]);

export default clerkMiddleware(async (auth, req) => {
  // Student dashboard — redirect to sign-in (avoid auth.protect() rewrite 404 in dev)
  if (isStudentRoute(req)) {
    const { userId } = await auth();
    if (!userId) {
      const signIn = new URL("/sign-in", req.url);
      signIn.searchParams.set("redirect_url", req.nextUrl.pathname + req.nextUrl.search);
      return NextResponse.redirect(signIn);
    }
    return;
  }

  // Admin dashboard — must be signed in AND have admin role
  if (isAdminRoute(req)) {
    const { userId, sessionClaims } = await auth();
    if (!userId) {
      return NextResponse.redirect(new URL("/admin/sign-in", req.url));
    }
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
