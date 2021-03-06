# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_07_173617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "damaged_items", force: :cascade do |t|
    t.string "title"
    t.string "delivered_by"
    t.text "obs"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["filial_id"], name: "index_damaged_items_on_filial_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "operador"
    t.integer "status", default: 1, null: false
    t.index ["filial_id"], name: "index_destinations_on_filial_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "title"
    t.decimal "value"
    t.text "obs"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["filial_id"], name: "index_expenses_on_filial_id"
  end

  create_table "filials", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category", default: 2, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "machine_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["machine_id"], name: "index_items_on_machine_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reference"
    t.index ["filial_id"], name: "index_machines_on_filial_id"
  end

  create_table "product_prices", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.integer "quantity", default: 0, null: false
    t.index ["product_id"], name: "index_product_prices_on_product_id"
  end

  create_table "product_sales", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id", null: false
    t.bigint "sale_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_sales_on_product_id"
    t.index ["sale_id"], name: "index_product_sales_on_sale_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.string "code"
    t.string "reference"
    t.string "product_code"
    t.integer "category", default: 1, null: false
    t.index ["filial_id"], name: "index_products_on_filial_id"
  end

  create_table "sale_products", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id", null: false
    t.bigint "sale_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.json "prices", default: []
    t.index ["product_id"], name: "index_sale_products_on_product_id"
    t.index ["sale_id"], name: "index_sale_products_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "destination_filial_id"
    t.bigint "destination_id"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.integer "status", default: 0, null: false
    t.text "obs"
    t.integer "quantity"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_sales_on_category_id"
    t.index ["destination_id"], name: "index_sales_on_destination_id"
    t.index ["filial_id"], name: "index_sales_on_filial_id"
  end

  create_table "similars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_similars_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role"
    t.bigint "filial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["filial_id"], name: "index_users_on_filial_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "damaged_items", "filials"
  add_foreign_key "destinations", "filials"
  add_foreign_key "expenses", "filials"
  add_foreign_key "items", "machines"
  add_foreign_key "machines", "filials"
  add_foreign_key "product_prices", "products"
  add_foreign_key "products", "filials"
  add_foreign_key "sale_products", "products"
  add_foreign_key "sale_products", "sales"
  add_foreign_key "sales", "categories"
  add_foreign_key "sales", "destinations"
  add_foreign_key "sales", "filials"
  add_foreign_key "similars", "items"
  add_foreign_key "users", "filials"
end
