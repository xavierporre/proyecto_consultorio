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

ActiveRecord::Schema[7.2].define(version: 2024_11_22_134033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "citas_disponibles", force: :cascade do |t|
    t.datetime "fecha_hora", null: false
    t.string "estado", default: "disponible", null: false
    t.bigint "horario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["horario_id"], name: "index_citas_disponibles_on_horario_id"
  end

  create_table "horarios", force: :cascade do |t|
    t.date "fecha"
    t.time "hora_inicio"
    t.time "hora_fin"
    t.integer "intervalo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "psicologos", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_psicologos_on_email", unique: true
    t.index ["reset_password_token"], name: "index_psicologos_on_reset_password_token", unique: true
  end

  add_foreign_key "citas_disponibles", "horarios"
end
