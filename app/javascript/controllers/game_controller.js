import { Controller } from "@hotwired/stimulus"
import { compare } from "game/compare"
import confetti from "canvas-confetti"

const ATTRS = ["gender", "race", "morality", "groups", "occupations", "powers", "antagonists"]
const HINTS = [[3, "habitation", "Habitação"], [5, "description", "Descrição"], [7, "palette", "Paleta"]]

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

    this.filter()
    this.render()
  }

  filter() {
    const typed = this.inputTarget.value.trim().toLowerCase()
    this.optionsTarget.innerHTML = this.characters
      .filter((c) => !this.guesses.includes(c.id) && c.name.toLowerCase().includes(typed))
      .slice(0, 7)
      .map((c) => `<option value="${c.name}">`)
      .join("")
  }

  guess(event) {
    event.preventDefault()
    const typed = this.inputTarget.value.trim().toLowerCase()
    if (!typed) return

    const available = this.characters.filter((c) => !this.guesses.includes(c.id))
    // Match exato por nome/alias; senão, o primeiro que contém o texto (igual à lista).
    const found =
      available.find((c) => c.name.toLowerCase() === typed || c.aliases.some((a) => a.toLowerCase() === typed)) ||
      available.find((c) => c.name.toLowerCase().includes(typed))

    if (!found) return
    this.inputTarget.value = ""

    this.guesses.push(found.id)
    localStorage.setItem(this.key, JSON.stringify(this.guesses))
    this.filter()
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
      this.inputTarget.disabled = true
      this.save()
      // Espera as cartas terminarem de virar antes de comemorar.
      setTimeout(() => {
        this.statusTarget.textContent = `Acertou em ${this.guesses.length} tentativa(s): ${this.answer.name}!`
        confetti({ particleCount: 150, spread: 80, origin: { y: 0.6 } })
      }, 1500)
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
