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

ActiveRecord::Schema.define(version: 2018_10_14_001926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_subscriptions", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.bigint "user_id", null: false
    t.boolean "autopost", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_feed_subscriptions_on_discarded_at"
    t.index ["feed_id", "user_id"], name: "index_feed_subscriptions_on_feed_id_and_user_id", unique: true
    t.index ["feed_id"], name: "index_feed_subscriptions_on_feed_id"
    t.index ["user_id"], name: "index_feed_subscriptions_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "url", null: false
    t.string "title", default: "", null: false
    t.string "home_page_url", default: "", null: false
    t.datetime "refreshed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "etag"
    t.string "last_modified_at"
    t.integer "status", default: 0, null: false
    t.string "refresh_message"
    t.index ["url"], name: "index_feeds_on_url", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.string "item_id", null: false
    t.text "content_html", default: "", null: false
    t.text "content_text", default: "", null: false
    t.string "title", default: "", null: false
    t.string "url", default: "", null: false
    t.datetime "published_at"
    t.datetime "modified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id", "item_id"], name: "index_posts_on_feed_id_and_item_id", unique: true
    t.index ["feed_id"], name: "index_posts_on_feed_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "feed_subscription_id", null: false
    t.text "body"
    t.integer "status", default: 0, null: false
    t.datetime "posted_at"
    t.string "posted_tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_job_id"
    t.datetime "will_post_at"
    t.string "media_urls", default: [], array: true
    t.integer "position", default: 0, null: false
    t.index ["feed_subscription_id"], name: "index_tweets_on_feed_subscription_id"
    t.index ["post_id"], name: "index_tweets_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: ""
    t.string "name", default: ""
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "twitter_access_token"
    t.string "twitter_access_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.datetime "subscription_expires_at"
    t.datetime "subscription_renews_at"
  end

  add_foreign_key "feed_subscriptions", "feeds"
  add_foreign_key "feed_subscriptions", "users"
end
