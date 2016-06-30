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

ActiveRecord::Schema.define(version: 20160630030152) do

  create_table "caregivers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "caregivers", ["user_id"], name: "index_caregivers_on_user_id"

  create_table "requested_actions", force: :cascade do |t|
    t.string   "device_id"
    t.string   "requested_service"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "unregistered_devices", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "device_id"
    t.string   "unique_id"
    t.boolean  "active",     default: false, null: false
  end

  add_index "unregistered_devices", ["device_id"], name: "index_unregistered_devices_on_device_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "device_id"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["device_id"], name: "index_users_on_device_id", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
