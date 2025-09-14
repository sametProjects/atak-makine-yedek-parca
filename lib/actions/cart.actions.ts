"use server";

import { CartItem } from "@/types";

export async function addItemToCart(data: CartItem) {
  console.log("data:", data);

  return {
    success: true,
    message: "Item added to the cart",
  };
}
