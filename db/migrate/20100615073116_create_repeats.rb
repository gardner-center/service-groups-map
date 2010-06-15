class CreateRepeats < ActiveRecord::Migration
  def self.up
    create_table :repeats do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :repeats
  end
end
