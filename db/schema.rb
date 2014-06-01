# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140531054454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "token",      limit: 60
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["token"], name: "index_access_tokens_on_token", using: :btree
  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id", using: :btree

  create_table "emails", force: true do |t|
    t.string   "mailer",     limit: 30
    t.string   "action",     limit: 30
    t.text     "target"
    t.text     "options"
    t.boolean  "sent",                  default: false
    t.datetime "sent_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["sent"], name: "index_emails_on_sent", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 30
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 60
    t.string   "login_name",      limit: 30
    t.integer  "role_id"
  end

  add_index "users", ["login_name"], name: "index_users_on_login_name", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
