import { Controller } from "@hotwired/stimulus"
import { compare } from "game/compare"

const ATTRS = ["gender", "morality", "groups", "occupations", "powers", "antagonists"]
const HINTS = [[3, "habitation", "Habitação"], [5, "quote", "Frase"], [7, "palette", "Paleta"]]

export default class extends Controller {
  static targets = ["input", "options", "rows", "hints", "status"]

  async connect() {
    const [characters, daily] = await Promise.all([
      fetch("/characters.json").then((r) => r.json()),
      fetch("/api/daily.json").then((r) => r.json())
    ])

    this.characters = characters
    this.answer = characters.find((c) => c.id === daily.character_id)
    this.key = `dcdle:classic:${daily.date}`
    this.guesses = JSON.parse(localStorage.getItem(this.key) || "[]")

    this.optionsTarget.innerHTML = characters.map((c) => `<option value="${c.name}">`).join("")
    this.render()
  }

  guess(event) {
    event.preventDefault()
    const typed = this.inputTarget.value.trim().toLowerCase()
    const found = this.characters.find((c) =>
      c.name.toLowerCase() === typed || c.aliases.some((a) => a.toLowerCase() === typed))

    this.inputTarget.value = ""
    if (!found || this.guesses.includes(found.id)) return

    this.guesses.push(found.id)
    localStorage.setItem(this.key, JSON.stringify(this.guesses))
    this.render()
  }

  render() {
    // Mais recente no topo.
    this.rowsTarget.innerHTML = this.guesses
      .map((id) => this.row(this.characters.find((c) => c.id === id)))
      .reverse()
      .join("")

    this.hintsTarget.innerHTML = HINTS.map(([at, key, label]) => {
      if (this.guesses.length < at) {
        return `<li class="locked">${label} — em ${at - this.guesses.length} tentativa(s)</li>`
      }
      return `<li><b>${label}:</b> ${this.hint(key)}</li>`
    }).join("")

    if (this.won) {
      this.statusTarget.textContent = `Acertou em ${this.guesses.length} tentativa(s): ${this.answer.name}!`
      this.inputTarget.disabled = true
      this.save()
    }
  }

  // Visitante recebe 401 e ignora — jogar sem conta funciona, só não guarda estatística.
  save() {
    if (this.saved) return
    this.saved = true

    fetch("/api/results", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]")?.content
      },
      body: JSON.stringify({ attempts: this.guesses.length, won: true })
    })
  }

  get won() {
    return this.guesses.at(-1) === this.answer.id
  }

  row(character) {
    const cells = ATTRS.map((attr) => {
      const value = character.attributes[attr]
      const state = compare(value, this.answer.attributes[attr])
      return `<td class="${state}">${[value].flat().join(", ")}</td>`
    })
    return `<tr><td class="name">${character.name}</td>${cells.join("")}</tr>`
  }

  hint(key) {
    const value = this.answer.hints[key]
    if (key !== "palette") return value
    return value.map((color) => `<span class="swatch" style="background:${color}"></span>`).join("")
  }
}
