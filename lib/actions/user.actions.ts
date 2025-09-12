"use server";

import { signIn, signOut } from "@/auth";
import { signInFormSchema } from "../validators";

function isRedirectError(error: unknown): boolean {
  return error instanceof Error && error.message === "NEXT_REDIRECT";
}

// Sign in the user with credentials
export async function signInWithCredentials(
  prevState: unknown,
  formData: FormData
) {
  try {
    // Set user from form and validate it with Zod schema
    const user = signInFormSchema.parse({
      email: formData.get("email"),
      password: formData.get("password"),
    });

    await signIn("credentials", user);

    return { success: true, message: "Signed in successfully" };
  } catch (error) {
    if (isRedirectError(error)) {
      throw error;
    }

    return { success: false, message: "Invalid email or password" };
  }
}

// Sign the user out
export async function signOutUser() {
  // await signOut({ redirectTo: "/" });
  await signOut();
}
