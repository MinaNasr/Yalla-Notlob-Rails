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

ActiveRecord::Schema.define(version: 20180410203009) do

  create_table "friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id", "user_id"], name: "index_friends_on_friend_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "group_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id", "user_id"], name: "index_group_details_on_group_id_and_user_id", unique: true
    t.index ["user_id"], name: "fk_rails_04c7ee0483"
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "groupName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.index ["owner_id"], name: "fk_rails_5447bdb9c5"
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "type"
    t.boolean "order_finished", default: false
    t.bigint "order_id"
    t.string "user_name"
    t.boolean "viewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_notifications_on_order_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "order_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "order_id"
    t.bigint "user_id"
    t.string "comment"
    t.string "item_name", null: false
    t.integer "amount", default: 1
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["user_id"], name: "index_order_details_on_user_id"
  end

  create_table "order_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "join", default: false
    t.index ["order_id", "user_id"], name: "index_order_users_on_order_id_and_user_id", unique: true
    t.index ["order_id"], name: "index_order_users_on_order_id"
    t.index ["user_id"], name: "index_order_users_on_user_id"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "meal_name", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "restaurant_name", null: false
    t.string "status", default: "w"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_id"
    t.string "api_token"
    t.string "api_type"
  end

  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "group_details", "groups"
  add_foreign_key "group_details", "users"
  add_foreign_key "groups", "users", column: "owner_id"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "users"
  add_foreign_key "orders", "users"
end
