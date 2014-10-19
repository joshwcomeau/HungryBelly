class CreateCuisineUserJoinTable < ActiveRecord::Migration
  def change
    create_table :cuisines_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :cuisine
    end
  end
end
