import { test } from "node:test"
import assert from "node:assert/strict"
import { compare } from "../../app/javascript/game/compare.js"

test("atributo escalar", () => {
  assert.equal(compare("male", "male"), "hit")
  assert.equal(compare("male", "female"), "miss")
})

test("atributo de lista", () => {
  assert.equal(compare(["a", "b"], ["b", "a"]), "hit", "ordem não importa")
  assert.equal(compare(["a"], ["a", "b"]), "partial", "subconjunto não é acerto")
  assert.equal(compare(["a", "b"], ["a"]), "partial", "superconjunto não é acerto")
  assert.equal(compare(["x"], ["a", "b"]), "miss")
  assert.equal(compare([], []), "hit")
})
