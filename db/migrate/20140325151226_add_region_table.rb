class AddRegionTable < ActiveRecord::Migration
  def change
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

    add_index "region", ["grou_"], name: "region_idx_grou_", unique: false
    add_index "region", ["name", "start_pstidx", "finish_pstidx"], name: "unq_region_pstidx", unique: true
    add_index "region", ["name"], name: "region_idx_name", unique: false
    add_index "region", ["owner"], name: "region_idx_owner", unique: false
    add_index "region", ["region_order"], name: "region_idx_region_order", unique: false
  end
end
