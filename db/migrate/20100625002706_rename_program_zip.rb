class RenameProgramZip < ActiveRecord::Migration
  def self.up
    rename_column :programs, :zip, :zipcode
  end

  def self.down
    rename_column :programs, :zipcode, :zip
  end
end
