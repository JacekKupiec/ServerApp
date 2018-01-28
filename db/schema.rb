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

ActiveRecord::Schema.define(version: 20180128093413) do

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "store_name"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "guid"
    t.string "brand"
    t.integer "group_id"
    t.index ["group_id"], name: "index_products_on_group_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "subsums", force: :cascade do |t|
    t.integer "subtotal"
    t.integer "product_id"
    t.integer "token_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_subsums_on_product_id"
    t.index ["token_id"], name: "index_subsums_on_token_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "token_expiration_date"
    t.string "refresh_token"
    t.datetime "refresh_token_expiration_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
