class JoinTables < ActiveRecord::Migration
  def self.up
    create_table :programs_service_people, :id => false do |t|
      t.integer :service_person_id
      t.integer :program_id
    end
    create_table :categories_programs, :id => false do |t|
      t.integer :category_id
      t.integer :program_id
    end
    create_table :programs_styles, :id => false do |t|
      t.integer :style_id
      t.integer :program_id
    end
  end

  def self.down
    drop_table :programs_service_people
    drop_table :categories_programs
    drop_table :programs_styles
  end
end
