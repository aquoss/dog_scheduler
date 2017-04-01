require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe "Associations" do
    it { should belong_to(:dog) }
    it { should have_many(:scheduled_events) }
  end

  let(:dog) { Dog.create(name: "Lola") }
  it "can load and save" do
    Meal.create(food: "Kibbles n Bits", portion: "2 cups", dog_id: dog.id)
    expect(Meal.count).to eq 1
  end
end
