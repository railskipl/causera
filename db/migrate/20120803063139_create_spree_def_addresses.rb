class CreateSpreeDefAddresses < ActiveRecord::Migration
  def change
    create_table :spree_def_addresses do |t|
      t.string :address
      t.timestamps
    end
  end
end
