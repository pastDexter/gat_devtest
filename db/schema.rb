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

ActiveRecord::Schema.define(version: 20180228153507) do

  create_table "access_tokens", force: :cascade do |t|
    t.integer "panel_provider_id"
    t.string "key", null: false
    t.datetime "expiration_date"
    t.index ["key"], name: "index_access_tokens_on_key", unique: true
    t.index ["panel_provider_id"], name: "index_access_tokens_on_panel_provider_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_code", limit: 2
    t.integer "panel_provider_id"
    t.index ["country_code"], name: "index_countries_on_country_code", unique: true
    t.index ["panel_provider_id"], name: "index_countries_on_panel_provider_id"
  end

  create_table "location_groups", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.integer "panel_provider_id"
    t.index ["country_id"], name: "index_location_groups_on_country_id"
    t.index ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id"
  end

  create_table "location_groups_locations", id: false, force: :cascade do |t|
    t.integer "location_id", null: false
    t.integer "location_group_id", null: false
    t.index ["location_group_id", "location_id"], name: "index_location_groups_locations_join_table"
    t.index ["location_id", "location_group_id"], name: "index_locations_location_groups_join_table"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "external_id"
    t.string "secret_code"
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code", null: false
    t.index ["code"], name: "index_panel_providers_on_code", unique: true
  end

end
