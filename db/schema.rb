# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_19_154520) do

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
    t.integer "pos_id"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["pos_id"], name: "index_accounts_on_pos_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "accounts_roles", id: false, force: :cascade do |t|
    t.integer "account_id"
    t.integer "role_id"
    t.index ["account_id", "role_id"], name: "index_accounts_roles_on_account_id_and_role_id"
    t.index ["account_id"], name: "index_accounts_roles_on_account_id"
    t.index ["role_id"], name: "index_accounts_roles_on_role_id"
  end

  create_table "cashboxes", force: :cascade do |t|
    t.integer "pos_id"
    t.integer "product_id"
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
    t.integer "place_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_point_of_sales_on_place_id"
  end

  create_table "pos_product_stocks", force: :cascade do |t|
    t.integer "pos_id"
    t.integer "product_id"
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

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "pos_id"
    t.integer "product_id"
    t.integer "account_id"
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
    t.integer "product_id"
    t.string "weight"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

end
