# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100615073432) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "categories_programs", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "program_id"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "start_day_of_week"
    t.integer  "repeats"
    t.date     "range"
    t.integer  "age_min"
    t.integer  "age_max"
    t.integer  "cost"
    t.integer  "rating_numerator"
    t.integer  "rating_denominator"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repeats", :force => true do |t|
    t.string "name"
  end

  create_table "service_groups", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.date     "inception_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_people", :force => true do |t|
    t.integer  "service_group_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_persons_programs", :id => false, :force => true do |t|
    t.integer "service_person_id"
    t.integer "program_id"
  end

  create_table "styles", :force => true do |t|
    t.string "name"
  end

  create_table "styles_programs", :id => false, :force => true do |t|
    t.integer "style_id"
    t.integer "program_id"
  end

end
