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

ActiveRecord::Schema.define(version: 20160711214130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "migrations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state",      default: 0
    t.string   "from_url"
    t.string   "to_url"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "url"
    t.integer  "status_code"
    t.string   "redirect_location"
    t.boolean  "image"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "title"
    t.string   "meta_description"
    t.float    "response_time"
    t.boolean  "no_index",          default: false
    t.string   "redirect_through",                               array: true
    t.string   "type"
    t.integer  "migration_id"
    t.index ["migration_id"], name: "index_resources_on_migration_id", using: :btree
  end

end
