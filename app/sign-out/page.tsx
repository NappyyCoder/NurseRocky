"use client";

import { useClerk } from "@clerk/nextjs";
import { useSearchParams } from "next/navigation";
import { useEffect } from "react";

export default function SignOutPage() {
  const { signOut } = useClerk();
  const params = useSearchParams();
  const redirect = params.get("redirect") ?? "/";

  useEffect(() => {
    signOut({ redirectUrl: redirect });
  }, [signOut, redirect]);

  return (
    <main style={{ minHeight: "100vh", display: "flex", alignItems: "center", justifyContent: "center", fontFamily: "DM Sans, system-ui, sans-serif", background: "#f8fafc" }}>
      <p style={{ color: "#64748b", fontSize: "1rem" }}>Signing out…</p>
    </main>
  );
}
