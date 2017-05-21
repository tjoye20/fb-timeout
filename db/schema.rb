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

ActiveRecord::Schema.define(version: 20170521194135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facebook_users", force: :cascade do |t|
    t.string   "username",   null: false
    t.text     "token",      null: false
    t.text     "secret",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "picture"
  end

  create_table "google_users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "picture"
    t.text     "token"
    t.text     "secret"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "facebook_user_id"
    t.index ["facebook_user_id"], name: "index_google_users_on_facebook_user_id", using: :btree
  end

  add_foreign_key "google_users", "facebook_users"
end
