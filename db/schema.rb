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

ActiveRecord::Schema.define(version: 20180227142218) do

  create_table "countries", force: :cascade do |t|
    t.string "country_code", limit: 2
    t.integer "panel_provider_id"
    t.index ["panel_provider_id"], name: "index_countries_on_panel_provider_id"
  end

  create_table "location_groups", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.integer "panel_provider_id"
    t.index ["country_id"], name: "index_location_groups_on_country_id"
    t.index ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id"
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code", null: false
    t.index ["code"], name: "index_panel_providers_on_code", unique: true
  end

end
