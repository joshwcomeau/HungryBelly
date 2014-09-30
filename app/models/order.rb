class Order < ActiveRecord::Base
  has_many :cuisines

  accepts_nested_attributes_for :cuisines
end
