class ScheduledEvent < ActiveRecord::Base
  belongs_to :schedulable, polymorphic: true
  belongs_to :dog
end
