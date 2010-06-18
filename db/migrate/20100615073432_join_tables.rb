class JoinTables < ActiveRecord::Migration
  def self.up
    create_table :service_persons_programs, :id => false do |t|
      t.integer :service_person_id
      t.integer :program_id
    end
    create_table :categories_programs, :id => false do |t|
      t.integer :category_id
      t.integer :program_id
    end
    create_table :styles_programs, :id => false do |t|
      t.integer :style_id
      t.integer :program_id
    end
  end

  def self.down
    drop_table :programs_service_persons
    drop_table :programs_categories
    drop_table :programs_styles
  end
end
