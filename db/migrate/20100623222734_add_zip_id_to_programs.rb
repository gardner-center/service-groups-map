class AddZipIdToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :zip_id, :integer
  end

  def self.down
    remove_column :programs, :zip_id
  end
end
