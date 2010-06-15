class CreateServiceGroups < ActiveRecord::Migration
  def self.up
    create_table :service_groups do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.date :inception_date

      t.timestamps
    end
  end

  def self.down
    drop_table :service_groups
  end
end
