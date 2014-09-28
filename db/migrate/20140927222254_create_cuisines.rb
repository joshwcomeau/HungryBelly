class CreateCuisines < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string :name
      t.belongs_to :order
      t.timestamps
    end
  end
end
