import { Controller } from "@hotwired/stimulus"
import { compare } from "game/compare"
import confetti from "canvas-confetti"

const ATTRS = ["gender", "morality", "groups", "occupations", "powers", "antagonists"]
const HINTS = [[3, "palette", "Paleta"], [5, "habitation", "Habitação"], [7, "description", "Descrição"]]

// O traço só aparece com o <details> fechado — quem esconde/mostra é o CSS.
const EYE = `<svg class="eye" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
  <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>
  <line class="slash" x1="3" y1="21" x2="21" y2="3"/></svg>`

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
    // Lista própria em vez de <datalist>: datalist não renderiza imagem.
    this.optionsTarget.innerHTML = !typed ? "" : this.characters
      .filter((c) => !this.guesses.includes(c.id) && c.name.toLowerCase().includes(typed))
      .slice(0, 7)
      .map((c) => `<li data-name="${c.name}">${this.avatar(c)}${c.name}</li>`)
      .join("")
  }

  pick(event) {
    const option = event.target.closest("li")
    if (!option) return
    this.inputTarget.value = option.dataset.name
    this.guess(event)
  }

  avatar(character) {
    return `<img src="${character.image}" alt="" loading="lazy">`
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

    // Dica nasce fechada. render() reconstrói a lista a cada palpite, então guarda as abertas.
    const shown = [...this.hintsTarget.querySelectorAll("details[open]")].map((d) => d.dataset.key)

    this.hintsTarget.innerHTML = HINTS.map(([at, key, label]) => {
      if (this.guesses.length < at) {
        return `<li class="locked">${label} — em ${at - this.guesses.length} tentativa(s)</li>`
      }
      return `<li><details data-key="${key}" ${shown.includes(key) ? "open" : ""}>
        <summary>${EYE}<b>${label}</b></summary>${this.hint(key)}</details></li>`
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
    return `<tr><td class="avatar">${this.avatar(character)}</td><td class="name">${character.name}</td>${cells.join("")}</tr>`
  }

  hint(key) {
    const value = this.answer.hints[key]
    if (key !== "palette") return value
    return value.map((color) => `<span class="swatch" style="background:${color}"></span>`).join("")
  }
}
