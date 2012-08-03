class CreateDefAddresses < ActiveRecord::Migration
  def change
    create_table :def_addresses do |t|
      t.string :address
      t.timestamps
    end
  end
end
