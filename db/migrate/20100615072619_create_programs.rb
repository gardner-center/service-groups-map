class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :start_time
      t.integer :end_time
      t.integer :start_day_of_week
      t.integer :repeats
      t.date :range
      t.integer :age_min
      t.integer :age_max
      t.integer :cost
      t.integer :rating_numerator
      t.integer :rating_denominator
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
