class Cuisine < ActiveRecord::Base
  belongs_to :order
  has_and_belongs_to_many :users
end
