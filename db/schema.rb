# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_11_210230) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "adopters", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "address"
    t.text "phone", limit: 12
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "pub_year"
    t.string "category"
    t.string "image"
    t.string "library"
    t.string "description"
    t.string "condition_treatment"
    t.integer "adopt_status", limit: 1, default: 0
    t.decimal "adopt_amount"
    t.integer "release_year", limit: 4
    t.string "dedication", limit: 75
    t.string "recognition"
    t.integer "adopter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "adopt_time"
    t.index ["adopter_id"], name: "index_products_on_adopter_id"
  end

end
