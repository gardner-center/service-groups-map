class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :styles
  end
end
