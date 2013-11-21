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

ActiveRecord::Schema.define(:version => 20131121052149) do

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "intro"
    t.text     "description"
    t.string   "poster"
    t.string   "courseware"
    t.boolean  "public"
    t.integer  "comments_count"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "submit_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "mark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unread"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "action_user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "content"
    t.string   "action"
  end

  create_table "submits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "token"
    t.integer  "admin"
    t.string   "name"
    t.string   "password_reset_token"
    t.string   "password_reset_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "salt"
    t.string   "cad_id"
    t.string   "active_code"
    t.boolean  "is_activated"
    t.string   "avatar"
  end

end
