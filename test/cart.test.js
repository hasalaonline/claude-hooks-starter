import { test } from "node:test";
import assert from "node:assert/strict";
import { cartTotal } from "../src/cart.js";

test("adds up price x qty", () => {
  assert.equal(cartTotal([{ price: 10, qty: 2 }, { price: 5, qty: 1 }]), 25);
});

test("applies a discount", () => {
  assert.equal(cartTotal([{ price: 100, qty: 1 }], 0.1), 90);
});
