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

ActiveRecord::Schema.define(version: 20150127002530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "secret"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "goodreads_id"
    t.string   "small_image_url"
    t.string   "image_url"
    t.string   "title"
    t.string   "goodreads_rating"
  end

  create_table "followees", force: :cascade do |t|
    t.integer  "goodreads_id"
    t.string   "name"
    t.string   "link"
    t.string   "image_url"
    t.string   "small_image_url"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "followees", ["user_id"], name: "index_followees_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "followee_id"
    t.integer  "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ratings", ["followee_id"], name: "index_ratings_on_followee_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "goodreads_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "followees", "users"
  add_foreign_key "ratings", "followees"
end
