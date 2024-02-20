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

ActiveRecord::Schema[7.1].define(version: 2024_02_20_095219) do
  create_table "mobile_problem_lists", force: :cascade do |t|
    t.integer "mobile_id"
    t.integer "problem_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobile_id"], name: "index_mobile_problem_lists_on_mobile_id"
    t.index ["problem_list_id"], name: "index_mobile_problem_lists_on_problem_list_id"
  end

  create_table "mobiles", force: :cascade do |t|
    t.string "imei"
    t.string "model"
    t.string "brand"
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_mobiles_on_profile_id"
  end

  create_table "problem_lists", force: :cascade do |t|
    t.string "p_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.string "phonenumber"
    t.string "state"
    t.string "city"
    t.string "address"
    t.string "gender"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "dob"
  end

  add_foreign_key "mobile_problem_lists", "mobiles"
  add_foreign_key "mobile_problem_lists", "problem_lists"
  add_foreign_key "mobiles", "profiles"
end
