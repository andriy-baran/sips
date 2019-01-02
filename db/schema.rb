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

ActiveRecord::Schema.define(version: 2019_01_02_103329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "phone"
    t.float "rate_per_hour"
    t.string "avatar"
    t.bigint "pos_id"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["pos_id"], name: "index_accounts_on_pos_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "cashboxes", force: :cascade do |t|
    t.bigint "pos_id"
    t.bigint "product_id"
    t.integer "account_id"
    t.decimal "price_uah"
    t.string "kind"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pos_id"], name: "index_cashboxes_on_pos_id"
    t.index ["product_id"], name: "index_cashboxes_on_product_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "city"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_of_sales", force: :cascade do |t|
    t.bigint "place_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_point_of_sales_on_place_id"
  end

  create_table "pos_product_stocks", force: :cascade do |t|
    t.bigint "pos_id"
    t.bigint "product_id"
    t.float "on_hand", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pos_id"], name: "index_pos_product_stocks_on_pos_id"
    t.index ["product_id"], name: "index_pos_product_stocks_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "pos_id"
    t.bigint "product_id"
    t.bigint "account_id"
    t.float "weight_kilogram"
    t.string "kind"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_stocks_on_account_id"
    t.index ["pos_id"], name: "index_stocks_on_pos_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id"
    t.string "weight"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "cashboxes", "products"
  add_foreign_key "point_of_sales", "places"
  add_foreign_key "pos_product_stocks", "products"
  add_foreign_key "stocks", "accounts"
  add_foreign_key "stocks", "products"
  add_foreign_key "variants", "products"
end
