class AddAddressToSpreeUsers < ActiveRecord::Migration
  def change
     add_column :spree_users, :address, :string
  end
end
 