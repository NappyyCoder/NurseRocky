import { cookies } from "next/headers";
import { NextResponse } from "next/server";

const CLERK_COOKIE =
  /^(?:__session|__client_uat|__clerk(?:_|$)|__refresh)/;

function shouldClear(name: string): boolean {
  return CLERK_COOKIE.test(name);
}

/** Clears Clerk session cookies even when the handshake is broken. */
export async function GET(request: Request) {
  const url = new URL(request.url);
  const redirectParam = url.searchParams.get("redirect") ?? "/";
  const redirectTo = redirectParam.startsWith("/")
    ? new URL(redirectParam, url.origin)
    : new URL("/", url.origin);

  const response = NextResponse.redirect(redirectTo);
  const store = await cookies();

  for (const { name } of store.getAll()) {
    if (shouldClear(name)) {
      response.cookies.set(name, "", { maxAge: 0, path: "/" });
    }
  }

  return response;
}
