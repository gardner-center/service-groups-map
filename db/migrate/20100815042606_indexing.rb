class Indexing < ActiveRecord::Migration
  def self.up
    add_index :zips, :code
    add_index :programs, :lat
    add_index :programs, :lon
    add_index :served_areas, :program_id
    add_index :served_areas, :lat
    add_index :served_areas, :lon
    add_index :categories_programs, :category_id
    add_index :categories_programs, :program_id

  end

  def self.down
    remove_index :zips, :code
    remove_index :programs, :lat
    remove_index :programs, :lon
    remove_index :served_areas, :program_id
    remove_index :served_areas, :lat
    remove_index :served_areas, :lon
    remove_index :categories_programs, :category_id
    remove_index :categories_programs, :program_id
  end
end
