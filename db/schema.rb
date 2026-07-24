# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_22_151221) do
  create_table "character_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.text "notes"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_character_requests_on_user_id"
  end

  create_table "game_results", force: :cascade do |t|
    t.integer "attempts", null: false
    t.string "character_id", null: false
    t.datetime "created_at", null: false
    t.string "mode", default: "classic", null: false
    t.date "played_on", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.boolean "won", default: false, null: false
    t.index ["user_id", "mode", "played_on"], name: "index_game_results_on_user_id_and_mode_and_played_on", unique: true
    t.index ["user_id"], name: "index_game_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "character_requests", "users"
  add_foreign_key "game_results", "users"
end
