require 'rails_helper'

RSpec.describe WalksController, type: :controller do
  describe "POST#create" do
    let(:dog) { Dog.create(name:"Brutus") }
    it "creates a Walk for a dog" do
      expect do
        post :create, { location: "Muir Woods", leash_required?: false, dog_id: dog.id }
      end.to change { Walk.count }.by 1

      expect(Walk.last.location).to eq "Muir Woods"
      expect(Walk.last.leash_required?).to eq false
      expect(Walk.last.dog_id).to eq dog.id
    end

    it "returns 201 and renders the Walk attributes" do
      post :create, { location: "Muir Woods", leash_required?: false, dog_id: dog.id }
      expect(response.status).to eq 201

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to be_present
      expect(response_json["location"]).to eq "Muir Woods"
      expect(response_json["leash_required?"]).to eq false
      expect(response_json["dog_id"]).to eq dog.id
    end
  end
end
