class JoinTables < ActiveRecord::Migration
  def self.up
    create_table :programs_service_persons do |t|
      t.integer :program_id
      t.integer :service_person_id
    end
    create_table :programs_categories do |t|
      t.integer :program_id
      t.integer :category_id
    end
    create_table :programs_styles do |t|
      t.integer :program_id
      t.integer :style_id
    end
  end

  def self.down
    drop_table :programs_service_persons
    drop_table :programs_categories
    drop_table :programs_styles
  end
end
