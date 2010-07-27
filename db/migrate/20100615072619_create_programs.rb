class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.integer :service_group_id
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.decimal :start_time, :precision => 4, :scale => 2
      t.decimal :end_time, :precision => 4, :scale => 2
      t.integer :start_day_of_week
      t.integer :repeats
      t.date :range
      t.integer :age_min
      t.integer :age_max
      t.decimal :cost, :precision => 6, :scale => 2
      t.integer :rating_numerator
      t.integer :rating_denominator
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :website
      t.string :formatted_address
      t.decimal  "lat",        :precision => 15, :scale => 10
      t.decimal  "lon",        :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
