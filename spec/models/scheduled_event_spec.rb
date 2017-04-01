require 'rails_helper'

RSpec.describe ScheduledEvent, type: :model do
  let(:dog) { Dog.create(name: "Lola") }
  let(:meal) { Meal.create(food: "Kibbles n Bits", portion: "2 cups", dog_id: dog.id) }
  it "can load and save" do
    ScheduledEvent.create(start_time: "2017-01-01 08:00:00 -0800", end_time: "2017-01-01 08:15:00 -0800", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: meal.id, dog_id: dog.id)
    expect(ScheduledEvent.count).to eq 1
  end
end
