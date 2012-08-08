class AddDetailsToSpreeUsers < ActiveRecord::Migration
  def change
     add_column :spree_users, :fname, :string
     add_column :spree_users, :lname, :string
     add_column :spree_users, :city, :string
     add_column :spree_users, :zip, :integer
     add_column :spree_users, :phone, :integer
     add_column :spree_users, :state_id, :string
     add_column :spree_users, :country_id, :string
  end
end
