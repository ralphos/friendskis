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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120821141935) do

  create_table "conversations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "tiny_url"
    t.string   "thumbnail_url"
    t.string   "medium_url"
    t.string   "large_url"
    t.string   "caption"
    t.integer  "user_id"
    t.boolean  "profile_pic"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "username"
    t.date     "date_of_birth"
    t.text     "bio"
    t.string   "preference"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "location"
    t.integer  "profile_pic"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
