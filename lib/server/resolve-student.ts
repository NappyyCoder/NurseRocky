import { currentUser } from "@clerk/nextjs/server";
import { supabaseAdmin } from "@/lib/supabase";
import { canonicalStudentEmail } from "@/lib/stripe-enrollment";
import {
  attachClerkToStudent,
  syncEnrollmentForClerkUser,
} from "@/lib/server/enrollment-link";

/** Resolve student id from Clerk session; links paid enrollment when possible. */
export async function resolveStudentId(userId: string): Promise<string | null> {
  await syncEnrollmentForClerkUser(userId);

  const user = await currentUser();
  const email = canonicalStudentEmail(user?.primaryEmailAddress?.emailAddress ?? "");

  const { data: byClerk } = await supabaseAdmin
    .from("students")
    .select("id, enrolled")
    .eq("clerk_user_id", userId)
    .maybeSingle();

  if (byClerk?.enrolled) return byClerk.id as string;

  if (email) {
    const { data: byEmail } = await supabaseAdmin
      .from("students")
      .select("id, enrolled")
      .eq("email", email)
      .maybeSingle();

    if (byEmail?.id) {
      const shouldLink =
        byEmail.enrolled ||
        !byClerk?.id ||
        byClerk.id === byEmail.id;

      if (shouldLink) {
        await attachClerkToStudent(
          userId,
          byEmail.id as string,
          {
            firstName: user?.firstName,
            lastName: user?.lastName,
          },
          byClerk?.id && byClerk.id !== byEmail.id
            ? (byClerk.id as string)
            : undefined
        );
      }

      if (byEmail.enrolled) return byEmail.id as string;
    }
  }

  if (byClerk?.id) return byClerk.id as string;
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
