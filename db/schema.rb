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

ActiveRecord::Schema.define(:version => 20140331040715) do

  create_table "conference_edition_translations", :force => true do |t|
    t.integer  "conference_edition_id"
    t.string   "locale"
    t.string   "tagline",                     :default => ""
    t.string   "country",                     :default => ""
    t.string   "city",                        :default => ""
    t.string   "venue",                       :default => ""
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.text     "notes_to_speakers",           :default => ""
    t.text     "notes_to_subscribers",        :default => ""
    t.text     "speakers_call_to_action",     :default => ""
    t.text     "sponsors_call_to_action",     :default => ""
    t.text     "registration_call_to_action", :default => ""
    t.text     "news_intro",                  :default => ""
    t.text     "about",                       :default => ""
  end

  add_index "conference_edition_translations", ["conference_edition_id"], :name => "index_conference_edition_translations_on_conference_edition_id"
  add_index "conference_edition_translations", ["locale"], :name => "index_conference_edition_translations_on_locale"

  create_table "conference_editions", :force => true do |t|
    t.integer  "conference_id",                                             :null => false
    t.date     "from_date",                                                 :null => false
    t.date     "to_date",                                                   :null => false
    t.string   "kind",                          :default => "single_track", :null => false
    t.string   "promo_video_provider",          :default => ""
    t.string   "promo_video_uid",               :default => ""
    t.string   "logo",                          :default => ""
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "sponsorship_packages_pdf",      :default => ""
    t.string   "registration_url",              :default => ""
    t.boolean  "is_registration_open",          :default => false
    t.boolean  "is_call_for_proposals_open",    :default => true
    t.boolean  "is_call_for_sponsorships_open", :default => true
    t.boolean  "is_schedule_available",         :default => false
    t.boolean  "is_location_available",         :default => false
    t.boolean  "is_email_subscription_enabled", :default => true,           :null => false
    t.text     "custom_styles",                 :default => ""
    t.string   "custom_css_file",               :default => ""
    t.string   "venue_address",                 :default => ""
    t.float    "venue_latitude"
    t.float    "venue_longitude"
    t.boolean  "is_talk_voting_open",           :default => false
    t.boolean  "is_speaker_listing_available",  :default => false,          :null => false
  end

  create_table "conference_editions_users", :force => true do |t|
    t.integer "conference_edition_id"
    t.integer "user_id"
  end

  add_index "conference_editions_users", ["conference_edition_id"], :name => "index_conference_editions_users_on_conference_edition_id"
  add_index "conference_editions_users", ["user_id"], :name => "index_conference_editions_users_on_user_id"

  create_table "conferences", :force => true do |t|
    t.string   "subdomain",              :default => "", :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "twitter_username",       :default => ""
    t.string   "twitter_hashtag",        :default => ""
    t.string   "facebook_page_username", :default => ""
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "owner_id",                               :null => false
    t.string   "custom_domain",          :default => ""
    t.string   "disqus_shortname",       :default => "", :null => false
  end

  create_table "conferences_languages", :force => true do |t|
    t.integer "conference_id"
    t.integer "language_id"
  end

  add_index "conferences_languages", ["conference_id"], :name => "index_conferences_languages_on_conference_id"
  add_index "conferences_languages", ["language_id"], :name => "index_conferences_languages_on_language_id"

  create_table "identities", :force => true do |t|
    t.string   "provider",   :default => "", :null => false
    t.string   "uid",        :default => "", :null => false
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "images", :force => true do |t|
    t.integer  "conference_edition_id", :null => false
    t.string   "image",                 :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notification_translations", :force => true do |t|
    t.integer  "notification_id"
    t.string   "locale"
    t.string   "subject",         :default => "", :null => false
    t.text     "body",            :default => "", :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "notification_translations", ["locale"], :name => "index_notification_translations_on_locale"
  add_index "notification_translations", ["notification_id"], :name => "index_notification_translations_on_notification_id"

  create_table "notifications", :force => true do |t|
    t.integer  "conference_edition_id",                 :null => false
    t.integer  "organizer_id",                          :null => false
    t.string   "recipients",            :default => "", :null => false
    t.string   "recipient_emails",      :default => "", :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "organizer_invitations", :force => true do |t|
    t.integer  "inviter_id",            :null => false
    t.integer  "invitee_id"
    t.string   "invitee_email",         :null => false
    t.string   "token",                 :null => false
    t.integer  "conference_edition_id", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "title",      :default => "", :null => false
    t.text     "content",    :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "conference_edition_id", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale"
    t.string   "title",      :default => "", :null => false
    t.text     "summary",    :default => "", :null => false
    t.text     "body",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "post_translations", ["locale"], :name => "index_post_translations_on_locale"
  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "image",                 :default => ""
    t.integer  "conference_edition_id",                 :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "conference_edition_id",                 :null => false
  end

  create_table "slots", :force => true do |t|
    t.datetime "from_datetime",                             :null => false
    t.datetime "to_datetime",                               :null => false
    t.string   "kind",                  :default => "talk", :null => false
    t.integer  "conference_edition_id",                     :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "speaker_translations", :force => true do |t|
    t.integer  "speaker_id"
    t.string   "locale"
    t.text     "bio",        :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "speaker_translations", ["locale"], :name => "index_speaker_translations_on_locale"
  add_index "speaker_translations", ["speaker_id"], :name => "index_speaker_translations_on_speaker_id"

  create_table "speakers", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.string   "company",               :default => ""
    t.string   "avatar",                :default => ""
    t.string   "city",                  :default => ""
    t.string   "country",               :default => ""
    t.string   "twitter_username",      :default => ""
    t.string   "github_username",       :default => ""
    t.string   "email",                 :default => "", :null => false
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "conference_edition_id",                 :null => false
    t.string   "lanyrd_username",       :default => ""
    t.string   "job_title",             :default => ""
    t.string   "phone",                 :default => ""
    t.string   "website",               :default => ""
    t.string   "status",                :default => "", :null => false
  end

  create_table "speakers_talks", :id => false, :force => true do |t|
    t.integer "speaker_id"
    t.integer "talk_id"
  end

  add_index "speakers_talks", ["speaker_id", "talk_id"], :name => "index_speakers_talks_on_speaker_id_and_talk_id"
  add_index "speakers_talks", ["talk_id", "speaker_id"], :name => "index_speakers_talks_on_talk_id_and_speaker_id"

  create_table "sponsor_translations", :force => true do |t|
    t.integer  "sponsor_id"
    t.string   "locale"
    t.text     "description", :default => ""
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "sponsor_translations", ["locale"], :name => "index_sponsor_translations_on_locale"
  add_index "sponsor_translations", ["sponsor_id"], :name => "index_sponsor_translations_on_sponsor_id"

  create_table "sponsors", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.string   "kind",                  :default => ""
    t.string   "logo",                  :default => ""
    t.string   "website_url",           :default => ""
    t.integer  "conference_edition_id",                 :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "subscribers", :force => true do |t|
    t.integer  "conference_edition_id"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "talk_translations", :force => true do |t|
    t.integer  "talk_id"
    t.string   "locale"
    t.string   "title",      :default => "", :null => false
    t.text     "abstract",   :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "talk_translations", ["locale"], :name => "index_talk_translations_on_locale"
  add_index "talk_translations", ["talk_id"], :name => "index_talk_translations_on_talk_id"

  create_table "talk_votes", :force => true do |t|
    t.integer  "talk_id",                               :null => false
    t.integer  "organizer_id",                          :null => false
    t.integer  "vote",                                  :null => false
    t.string   "comment",               :default => "", :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "conference_edition_id"
  end

  add_index "talk_votes", ["organizer_id"], :name => "index_talk_votes_on_organizer_id"
  add_index "talk_votes", ["talk_id", "organizer_id"], :name => "index_talk_votes_on_talk_id_and_organizer_id", :unique => true
  add_index "talk_votes", ["talk_id"], :name => "index_talk_votes_on_talk_id"

  create_table "talks", :force => true do |t|
    t.string   "title",                 :default => "",        :null => false
    t.text     "abstract",              :default => ""
    t.string   "status",                :default => "pending", :null => false
    t.string   "slides_url",            :default => ""
    t.string   "video_url",             :default => ""
    t.integer  "slot_id"
    t.integer  "room_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "conference_edition_id",                        :null => false
    t.text     "notes_to_organizers",   :default => ""
    t.string   "language",                                     :null => false
    t.integer  "ranking"
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
