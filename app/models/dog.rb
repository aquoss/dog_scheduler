class Dog < ActiveRecord::Base
  has_many :meals
  has_many :walks
end
