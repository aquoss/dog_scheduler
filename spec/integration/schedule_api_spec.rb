require 'rails_helper'

RSpec.describe "the schedule API" do
  let!(:dog) { Dog.create(name: "Duke") }

  describe "querying the dog's schedule" do
    it "returns an empty array when there are no items" do
      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      expect(JSON[response.body]).to eq []
    end

    it "returns a list of items that were added to the dog's schedule" do
      pending "Implement the rest"

      # You can modify any of the following code as you make decisions on
      # how to set up and represent data in your system.

      post "/dogs/#{dog.id}/meals", {
        start_time: "2017-01-01 08:00:00 -0800",
        end_time: "2017-01-01 08:15:00 -0800",
        food: "Royal Canin Medium Puppy Dry"
      }

      post "/dogs/#{dog.id}/walks", {
        start_time: "2017-01-01 10:00:00 -0800",
        end_time: "2017-01-01 11:45:00 -0800",
        location: "Fort Funston"
      }

      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      scheduled_events = JSON[response.body]
      expect(scheduled_events.count).to eq 2
      expect(scheduled_events[0]["type"]).to eq "meal"
      expect(scheduled_events[0]["start_time"]).to eq "2017-01-01 08:00:00 -0800"
      expect(scheduled_events[0]["end_time"]).to eq "2017-01-01 08:15:00 -0800"
      expect(scheduled_events[0]["food"]).to eq "Royal Canin Medium Puppy Dry"

      expect(scheduled_events[1]["type"]).to eq "walk"
      expect(scheduled_events[1]["start_time"]).to eq "2017-01-01 10:00:00 -0800"
      expect(scheduled_events[1]["end_time"]).to eq "2017-01-01 11:45:00 -0800"
      expect(scheduled_events[1]["location"]).to eq "Fort Funston"
    end
  end
end
