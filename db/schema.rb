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

ActiveRecord::Schema.define(version: 20150325160941) do

  create_table "repositories", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "namespace",  limit: 255, null: false
    t.string   "token",      limit: 64,  null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "repositories", ["token"], name: "index_repositories_on_token", unique: true, using: :btree

  create_table "test_reports", force: :cascade do |t|
    t.integer  "repository_id",   limit: 4,     null: false
    t.string   "branch",          limit: 255,   null: false
    t.float    "covered_percent", limit: 24,    null: false
    t.text     "json",            limit: 65535, null: false
    t.datetime "committed_at",                  null: false
    t.datetime "run_at",                        null: false
    t.datetime "created_at",                    null: false
  end

  add_index "test_reports", ["repository_id"], name: "index_test_reports_on_repository_id", using: :btree

end