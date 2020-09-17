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

ActiveRecord::Schema.define(version: 2020_09_16_190306) do

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
    t.string "adopter_fname"
    t.string "adopter_lname"
    t.string "adopter_address"
    t.integer "adopter_phone", limit: 10
    t.string "adopter_email"
    t.datetime "adopt_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
