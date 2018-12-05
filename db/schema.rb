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

ActiveRecord::Schema.define(version: 2018_12_05_122851) do

  create_table "cashboxes", force: :cascade do |t|
    t.integer "pos_id"
    t.integer "product_id"
    t.string "price"
    t.string "kind"
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

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "pos_id"
    t.integer "product_id"
    t.string "weight"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
