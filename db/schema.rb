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

ActiveRecord::Schema.define(version: 20161214085347) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "count"
    t.integer  "price"
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "created_at"], name: "index_cart_items_on_cart_id_and_created_at"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.boolean  "isStatic"
    t.integer  "totalprice"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_carts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.text     "decription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_chats_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id", "product_id", "created_at"], name: "index_comments_on_user_id_and_product_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "product_vieweds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_vieweds_on_product_id"
    t.index ["user_id", "product_id", "created_at"], name: "index_product_vieweds_on_user_id_and_product_id_and_created_at"
    t.index ["user_id"], name: "index_product_vieweds_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.text     "productname"
    t.integer  "productPrice"
    t.boolean  "productStatus"
    t.text     "productDescription"
    t.integer  "rate"
    t.string   "upPicture"
    t.integer  "category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id", "created_at"], name: "index_products_on_category_id_and_created_at"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "ratePoint"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_rates_on_product_id"
    t.index ["user_id", "product_id", "created_at"], name: "index_rates_on_user_id_and_product_id_and_created_at"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "suggests", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_suggests_on_product_id"
    t.index ["user_id", "product_id", "created_at"], name: "index_suggests_on_user_id_and_product_id_and_created_at"
    t.index ["user_id"], name: "index_suggests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: ""
    t.boolean  "is_admin",               default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
