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

ActiveRecord::Schema.define(version: 20131020222552) do

  create_table "battles", force: true do |t|
    t.integer  "rubygem_x_id"
    t.integer  "rubygem_y_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "metric_results", force: true do |t|
    t.string   "kind"
    t.float    "result"
    t.datetime "expires_at", default: '0000-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rubygem_id"
  end

  create_table "rubygems", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "karma"
    t.boolean  "queued",           default: false
    t.text     "metadata"
    t.text     "categories_karma"
    t.integer  "open_issues"
    t.datetime "pushed_at"
    t.integer  "forks"
    t.integer  "watchers"
    t.text     "description"
    t.string   "full_name"
  end

  create_table "searches", force: true do |t|
    t.string   "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "results"
  end

end
