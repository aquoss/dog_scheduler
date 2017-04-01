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

ActiveRecord::Schema.define(version: 20170401211846) do

  create_table "dogs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string   "food"
    t.string   "portion"
    t.integer  "dog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meals", ["dog_id"], name: "index_meals_on_dog_id"

  create_table "scheduled_events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.date     "date"
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
    t.integer  "dog_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "scheduled_events", ["dog_id"], name: "index_scheduled_events_on_dog_id"
  add_index "scheduled_events", ["schedulable_type", "schedulable_id"], name: "index_scheduled_events_on_schedulable_type_and_schedulable_id"

  create_table "walks", force: :cascade do |t|
    t.string   "location"
    t.boolean  "leash_required?"
    t.integer  "dog_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "walks", ["dog_id"], name: "index_walks_on_dog_id"

end
