class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email

      t.string :street
      t.string :city
      t.string :postal_code

      t.integer :servings
      t.decimal :budget

      t.text :notes

      t.timestamps
    end
  end
end
