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

ActiveRecord::Schema.define(version: 20170604014704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "facebook_user_id"
    t.string   "name"
    t.text     "info"
    t.string   "date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "uuid"
    t.text     "location"
    t.string   "fb_event_id"
    t.boolean  "mailed?",          default: false
    t.text     "ticket_link"
    t.index ["facebook_user_id"], name: "index_events_on_facebook_user_id", using: :btree
  end

  create_table "facebook_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "picture"
    t.string   "uuid"
    t.string   "username"
    t.text     "token"
    t.text     "secret"
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
    t.string   "uuid"
    t.string   "refresh_token"
    t.index ["facebook_user_id"], name: "index_google_users_on_facebook_user_id", using: :btree
  end

  add_foreign_key "google_users", "facebook_users"
end
