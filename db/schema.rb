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

ActiveRecord::Schema.define(version: 20140718074650) do

  create_table "collaborations", force: true do |t|
    t.integer "wiki_id"
    t.integer "user_id"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.integer  "wiki_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "slug"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true

  create_table "plans", force: true do |t|
    t.string  "stripe_id"
    t.string  "name"
    t.decimal "price"
    t.integer "duration"
  end

  create_table "subpages", force: true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wiki_id"
    t.string   "slug"
  end

  add_index "subpages", ["slug"], name: "index_subpages_on_slug", unique: true

  create_table "subscriptions", force: true do |t|
    t.integer "plan_id"
    t.integer "user_id"
    t.string  "stripe_customer_id"
    t.string  "last4"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "address",                default: "", null: false
    t.string   "postcode",               default: "", null: false
    t.string   "state",                  default: "", null: false
    t.string   "country"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profilepic"
    t.integer  "role"
    t.boolean  "subscribed"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "wikis", force: true do |t|
    t.string   "name"
    t.boolean  "public"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "slug"
  end

  add_index "wikis", ["slug"], name: "index_wikis_on_slug", unique: true

end
