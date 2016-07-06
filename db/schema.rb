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

ActiveRecord::Schema.define(version: 20160616185550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "migrations", force: :cascade do |t|
    t.string   "name"
    t.integer  "current_site_id"
    t.integer  "new_site_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["current_site_id"], name: "index_migrations_on_current_site_id", using: :btree
    t.index ["new_site_id"], name: "index_migrations_on_new_site_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.string   "url"
    t.integer  "http_code"
    t.string   "redirect_location"
    t.boolean  "image"
    t.integer  "site_id"
    t.text     "content"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["site_id"], name: "index_resources_on_site_id", using: :btree
    t.index ["url", "site_id"], name: "index_resources_on_url_and_site_id", unique: true, using: :btree
  end

  create_table "sites", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "migrations", "sites", column: "current_site_id"
  add_foreign_key "migrations", "sites", column: "new_site_id"
  add_foreign_key "resources", "sites"
end
