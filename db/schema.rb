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

ActiveRecord::Schema.define(version: 2021_05_27_113853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "location"
    t.string "headline"
    t.string "alt"
    t.string "caption"
    t.text "content"
    t.string "picture", null: false
    t.boolean "display_comments", default: true, null: false
    t.datetime "published_at"
    t.string "slug", null: false
    t.bigint "category_id", null: false
    t.bigint "subcategory_id"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["subcategory_id"], name: "index_articles_on_subcategory_id"
    t.index ["team_id"], name: "index_articles_on_team_id"
  end

  create_table "articles_locations", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "location_id", null: false
    t.index ["article_id", "location_id"], name: "index_articles_locations_on_article_id_and_location_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "hidden", default: false
    t.integer "row_order"
    t.boolean "static", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.boolean "edited", default: false, null: false
    t.integer "children_count", default: 0
    t.bigint "parent_id"
    t.bigint "thread_id"
    t.bigint "user_id", null: false
    t.bigint "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["thread_id"], name: "index_comments_on_thread_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.boolean "positive", default: true
    t.bigint "feedbackable_id"
    t.string "feedbackable_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "home_articles", force: :cascade do |t|
    t.boolean "show", default: true, null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_home_articles_on_article_id"
  end

  create_table "home_breakdowns", force: :cascade do |t|
    t.boolean "show", default: true, null: false
    t.bigint "category_id", null: false
    t.bigint "subcategory_id"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_home_breakdowns_on_category_id"
    t.index ["subcategory_id"], name: "index_home_breakdowns_on_subcategory_id"
    t.index ["team_id"], name: "index_home_breakdowns_on_team_id"
  end

  create_table "home_photo_of_the_days", force: :cascade do |t|
    t.string "image", null: false
    t.string "title", null: false
    t.string "alt", null: false
    t.string "description", null: false
    t.string "author", null: false
    t.boolean "show", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "home_settings", force: :cascade do |t|
    t.boolean "show_popular_articles", default: true, null: false
    t.boolean "show_commented_articles", default: true, null: false
    t.string "popular_articles_period", default: "day", null: false
    t.string "commented_articles_period", default: "day", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "locale", null: false
    t.text "translation"
    t.boolean "hidden", default: false
    t.boolean "system", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["locale"], name: "index_languages_on_locale", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "title", null: false
    t.string "place_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_locations_on_place_id", unique: true
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.string "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.text "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "category_id", null: false
    t.integer "row_order"
    t.boolean "hidden", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["name", "category_id"], name: "index_subcategories_on_name_and_category_id", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "subcategory_id", null: false
    t.integer "row_order"
    t.boolean "hidden", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "subcategory_id"], name: "index_teams_on_name_and_subcategory_id", unique: true
    t.index ["subcategory_id"], name: "index_teams_on_subcategory_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "photo", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.datetime "blocked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "subcategories"
  add_foreign_key "articles", "teams"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "comments", column: "thread_id"
  add_foreign_key "comments", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "home_articles", "articles"
  add_foreign_key "home_breakdowns", "categories"
  add_foreign_key "home_breakdowns", "subcategories"
  add_foreign_key "home_breakdowns", "teams"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "teams", "subcategories"
end
