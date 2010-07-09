class Indexing < ActiveRecord::Migration
  def self.up
    add_index :zips, :code
    add_index :programs, :zipcode
  end

  def self.down
    remove_index :zips, :code
    remove_index :programs, :zipcode
  end
end
