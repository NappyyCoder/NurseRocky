import { auth, currentUser } from "@clerk/nextjs/server";
import { supabaseAdmin } from "@/lib/supabase";
import { canonicalStudentEmail } from "@/lib/stripe-enrollment";

/** Resolve enrolled student id from Clerk session (shared by student APIs). */
export async function resolveStudentId(userId: string): Promise<string | null> {
  const { data: byClerk } = await supabaseAdmin
    .from("students")
    .select("id")
    .eq("clerk_user_id", userId)
    .maybeSingle();

  if (byClerk?.id) return byClerk.id as string;

  const user = await currentUser();
  const email = canonicalStudentEmail(user?.primaryEmailAddress?.emailAddress ?? "");
  if (!email) return null;

  const { data: byEmail } = await supabaseAdmin
    .from("students")
    .select("id")
    .eq("email", email)
    .maybeSingle();

  if (byEmail?.id) {
    await supabaseAdmin
      .from("students")
      .update({
        clerk_user_id: userId,
        first_name: user?.firstName ?? null,
        last_name: user?.lastName ?? null,
      })
      .eq("id", byEmail.id);
    return byEmail.id as string;
  }

  return null;
}

export async function requireEnrolledStudent(userId: string) {
  const id = await resolveStudentId(userId);
  if (!id) return null;

  const { data } = await supabaseAdmin
    .from("students")
    .select("id, enrolled")
    .eq("id", id)
    .single();

  if (!data?.enrolled) return null;
  return data.id as string;
}
