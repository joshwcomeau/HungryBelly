class AddDrinkBooleanToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :drinks, :boolean
  end
end
