require 'rails_helper'

RSpec.describe "the schedule API" do
  let(:dog) { Dog.create(name: "Duke") }
  let(:meal) { Meal.create(food: "Royal Canin Medium Puppy Dry", portion: "3 scoops", dog_id: dog.id) }
  let(:walk) { Walk.create(location: "Muir Woods", leash_required?: false, dog_id: dog.id) }

  describe "querying the dog's schedule" do
    it "returns an empty array when there are no items" do
      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      expect(JSON[response.body]).to eq []
    end

    it "returns a list of items that were added to the dog's schedule" do
      post "/dogs/#{dog.id}/scheduled_events", {
        start_time: "2017-01-01 08:00:00 -0800",
        end_time: "2017-01-01 08:15:00 -0800",
        date: "2017-01-01",
        schedulable_type: "Meal",
        schedulable_id: meal.id,
        dog_id: dog.id,
      }

      post "/dogs/#{dog.id}/scheduled_events", {
        start_time: "2017-01-01 09:30:00 -0800",
        end_time: "2017-01-01 10:30:00 -0800",
        date: "2017-01-01",
        schedulable_type: "Walk",
        schedulable_id: walk.id,
        dog_id: dog.id,
      }

      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      scheduled_events = JSON[response.body]
      expect(scheduled_events.count).to eq 2
      expect(scheduled_events[0]["type"]).to eq "meal"
      expect(scheduled_events[0]["start_time"]).to eq "2017-01-01 08:00:00 -0800"
      expect(scheduled_events[0]["end_time"]).to eq "2017-01-01 08:15:00 -0800"
      expect(scheduled_events[0]["date"]).to eq "2017-01-01"
      expect(scheduled_events[0]["type_description"]["food"]).to eq "Royal Canin Medium Puppy Dry"
      expect(scheduled_events[0]["type_description"]["portion"]).to eq "3 Scoops"
      expect(scheduled_events[0]["type_description"]["id"]).to eq meal.id
      expect(scheduled_events[0]["type_description"]["dog_id"]).to eq dog.id

      expect(scheduled_events[1]["type"]).to eq "walk"
      expect(scheduled_events[1]["start_time"]).to eq "2017-01-01 09:30:00 -0800"
      expect(scheduled_events[1]["end_time"]).to eq "2017-01-01 10:30:00 -0800"
      expect(scheduled_events[1]["date"]).to eq "2017-01-01"
      expect(scheduled_events[1]["type_description"]["location"]).to eq "Muir Woods"
      expect(scheduled_events[1]["type_description"]["leash_required?"]).to eq false
      expect(scheduled_events[1]["type_description"]["id"]).to eq walk.id
      expect(scheduled_events[1]["type_description"]["dog_id"]).to eq dog.id
    end
  end
end
