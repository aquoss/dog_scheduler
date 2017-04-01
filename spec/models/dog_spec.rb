require 'rails_helper'

RSpec.describe Dog, type: :model do
  it "can load and save" do
    Dog.create(name: "Lola")
    expect(Dog.count).to eq 1
  end
end
