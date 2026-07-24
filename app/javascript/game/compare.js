// Escalar: acerta ou erra. Lista: conjunto igual = acerto, interseção = parcial.
export function compare(value, answer) {
  if (!Array.isArray(value)) return value === answer ? "hit" : "miss"
  if (value.length === answer.length && value.every((v) => answer.includes(v))) return "hit"
  return value.some((v) => answer.includes(v)) ? "partial" : "miss"
}
