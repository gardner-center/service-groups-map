class CreateServedAreas < ActiveRecord::Migration
  def self.up
    create_table :served_areas do |t|
      t.integer :program_id
      t.string :formatted_address
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lon, :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :served_areas
  end
end
