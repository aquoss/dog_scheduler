class Meal < ActiveRecord::Base
  belongs_to :dog
  has_many :scheduled_events, as: :schedulable
end
