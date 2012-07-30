class CreateDefAdds < ActiveRecord::Migration
  def change
    create_table :def_adds do |t|
      t.string :address
      t.timestamps
    end
  end
end
