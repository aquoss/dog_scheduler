require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe "Associations" do
    it { should have_many(:meals) }
    it { should have_many(:walks) }
  end

  it "can load and save" do
    Dog.create(name: "Lola")
    expect(Dog.count).to eq 1
  end
end
