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

ActiveRecord::Schema.define(:version => 20100709004405) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "categories_programs", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "program_id"
  end

  create_table "programs", :force => true do |t|
    t.integer  "service_group_id"
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "start_time",         :precision => 4, :scale => 2
    t.decimal  "end_time",           :precision => 4, :scale => 2
    t.integer  "start_day_of_week"
    t.integer  "repeats"
    t.date     "range"
    t.integer  "age_min"
    t.integer  "age_max"
    t.decimal  "cost",               :precision => 6, :scale => 2
    t.integer  "rating_numerator"
    t.integer  "rating_denominator"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "website"
    t.string   "formatted_address"
    t.decimal  "lat",        :precision => 15, :scale => 10
    t.decimal  "lon",        :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zip_id"
  end

  add_index "programs", ["zipcode"], :name => "index_programs_on_zipcode"

  create_table "programs_service_people", :id => false, :force => true do |t|
    t.integer "service_person_id"
    t.integer "program_id"
  end

  create_table "programs_styles", :id => false, :force => true do |t|
    t.integer "style_id"
    t.integer "program_id"
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

  create_table "styles", :force => true do |t|
    t.string "name"
  end

  create_table "zips", :force => true do |t|
    t.string   "code"
    t.string   "city"
    t.string   "state"
    t.decimal  "lat",        :precision => 15, :scale => 10
    t.decimal  "lon",        :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zips", ["code"], :name => "index_zips_on_code"

end
