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

ActiveRecord::Schema.define(:version => 20130512152749) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "conference_editions", :force => true do |t|
    t.date     "from_date",                                        :null => false
    t.date     "to_date",                                          :null => false
    t.string   "tagline",              :default => ""
    t.string   "kind",                 :default => "single_track", :null => false
    t.string   "status",               :default => "past",         :null => false
    t.string   "country",              :default => ""
    t.string   "city",                 :default => ""
    t.string   "venue",                :default => ""
    t.string   "promo_video_provider", :default => ""
    t.string   "promo_video_uid",      :default => ""
    t.string   "promo_image",          :default => ""
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "provider",   :default => "", :null => false
    t.string   "uid",        :default => "", :null => false
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title",                 :default => "", :null => false
    t.text     "body",                  :default => ""
    t.text     "summary",               :default => ""
    t.string   "image",                 :default => ""
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
    t.datetime "from_datetime"
    t.datetime "to_datetime"
    t.string   "kind",                  :default => "talk", :null => false
    t.integer  "conference_edition_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "speakers", :force => true do |t|
    t.string   "name",             :default => "", :null => false
    t.text     "bio",              :default => ""
    t.string   "company",          :default => ""
    t.string   "avatar",           :default => ""
    t.string   "city",             :default => ""
    t.string   "country",          :default => ""
    t.string   "twitter_username", :default => ""
    t.string   "github_username",  :default => ""
    t.string   "email",            :default => ""
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "speakers_talks", :id => false, :force => true do |t|
    t.integer "speaker_id"
    t.integer "talk_id"
  end

  add_index "speakers_talks", ["speaker_id", "talk_id"], :name => "index_speakers_talks_on_speaker_id_and_talk_id"
  add_index "speakers_talks", ["talk_id", "speaker_id"], :name => "index_speakers_talks_on_talk_id_and_speaker_id"

  create_table "sponsors", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.string   "description",           :default => ""
    t.string   "kind",                  :default => ""
    t.string   "logo",                  :default => ""
    t.integer  "conference_edition_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "talks", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.string   "abstract",   :default => ""
    t.string   "status",     :default => ""
    t.string   "slides_url", :default => ""
    t.string   "video_url",  :default => ""
    t.integer  "slot_id"
    t.integer  "room_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :default => "",     :null => false
    t.string   "nickname",   :default => ""
    t.string   "email",      :default => ""
    t.string   "image",      :default => ""
    t.string   "role",       :default => "user"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

end
