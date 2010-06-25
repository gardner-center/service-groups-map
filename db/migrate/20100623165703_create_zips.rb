class CreateZips < ActiveRecord::Migration
  def self.up
    create_table :zips do |t|
      t.string :code
      t.string :city
      t.string :state
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lon, :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :zips
  end
end
