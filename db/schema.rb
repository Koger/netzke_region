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

ActiveRecord::Schema.define(version: 20140326151226) do

  create_table "region", force: true do |t|
    t.integer  "owner"
    t.integer  "grou_"
    t.string   "name",          limit: 160
    t.string   "username",      limit: 80
    t.datetime "lastedit"
    t.integer  "start_pstidx"
    t.integer  "finish_pstidx"
    t.integer  "region_order",              default: 0, null: false
    t.integer  "pstidx_qty"
    t.date     "ins_date"
  end

  add_index "region", ["grou_"], name: "region_idx_grou_"
  add_index "region", ["name", "start_pstidx", "finish_pstidx"], name: "unq_region_pstidx", unique: true
  add_index "region", ["name"], name: "region_idx_name"
  add_index "region", ["owner"], name: "region_idx_owner"
  add_index "region", ["region_order"], name: "region_idx_region_order"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

end
