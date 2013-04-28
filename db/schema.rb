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

ActiveRecord::Schema.define(:version => 20130428031057) do

  create_table "conference_editions", :force => true do |t|
    t.string   "name",                  :default => "",             :null => false
    t.string   "description",           :default => ""
    t.string   "venue",                 :default => ""
    t.string   "kind",                  :default => "single_track"
    t.string   "promotional_video_url", :default => ""
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title",                 :default => "", :null => false
    t.string   "body",                  :default => ""
    t.string   "summary",               :default => ""
    t.integer  "conference_edition_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "slots", :force => true do |t|
    t.datetime "from"
    t.datetime "to"
    t.string   "kind",                  :default => "talk", :null => false
    t.integer  "conference_edition_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "speakers", :force => true do |t|
    t.string   "name",             :default => "", :null => false
    t.string   "description",      :default => ""
    t.string   "twitter_username", :default => ""
    t.string   "github_username",  :default => ""
    t.string   "email",            :default => ""
    t.integer  "talk_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.string   "description",           :default => ""
    t.string   "kind",                  :default => ""
    t.integer  "conference_edition_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "talks", :force => true do |t|
    t.string   "title",       :default => "", :null => false
    t.string   "description", :default => ""
    t.string   "status",      :default => ""
    t.string   "slides_url",  :default => ""
    t.string   "video_url",   :default => ""
    t.integer  "slot_id"
    t.integer  "room_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
