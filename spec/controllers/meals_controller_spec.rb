require 'rails_helper'

RSpec.describe MealsController, type: :controller do
  describe "POST#create" do
    let(:dog) { Dog.create(name:"Brutus") }
    it "creates a Meal for a dog" do
      expect do
        post :create, { food: "Kibbles n Bits", portion: "2 cups", dog_id: dog.id }
      end.to change { Meal.count }.by 1

      expect(Meal.last.food).to eq "Kibbles n Bits"
      expect(Meal.last.portion).to eq "2 cups"
      expect(Meal.last.dog_id).to eq dog.id
    end

    it "returns 201 and renders the Meal attributes" do
      post :create, { food: "Kibbles n Bits", portion: "2 cups", dog_id: dog.id }
      expect(response.status).to eq 201

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to be_present
      expect(response_json["food"]).to eq "Kibbles n Bits"
      expect(response_json["portion"]).to eq "2 cups"
      expect(response_json["dog_id"]).to eq dog.id
    end
  end
end
