require 'rails_helper'

RSpec.describe Walk, type: :model do
  describe "Associations" do
    it { should belong_to(:dog) }
    it { should have_many(:scheduled_events) }
  end

  let(:dog) { Dog.create(name: "Lola") }
  it "can load and save" do
    Walk.create(location: "Golden Gate Park", leash_required?: true, dog_id: dog.id)
    expect(Walk.count).to eq 1
  end
end
