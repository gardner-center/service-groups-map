class CreateServicePeople < ActiveRecord::Migration
  def self.up
    create_table :service_people do |t|
      t.integer :service_group_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :service_people
  end
end
