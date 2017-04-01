require 'rails_helper'

RSpec.describe ScheduledEventsController, type: :controller do
  describe "POST#create" do
    let(:dog) { Dog.create(name:"Brutus") }
    let(:meal) { Meal.create(food: "Kibbles n Bits", portion: "2 cups", dog_id: dog.id) }
    it "creates a Scheduled Event for a dog" do
      expect do
        post :create, scheduled_event: { start_time: "2017-01-01 08:00:00 -0800", end_time: "2017-01-01 08:15:00 -0800", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: meal.id, dog_id: dog.id }
      end.to change { ScheduledEvent.count }.by 1

      expect(ScheduledEvent.last.start_time).to eq "2017-01-01 08:00:00 -0800"
      expect(ScheduledEvent.last.end_time).to eq "2017-01-01 08:15:00 -0800"
      expect(ScheduledEvent.last.date).to eq "2017-01-01"
      expect(ScheduledEvent.last.schedulable_type).to eq "Meal"
      expect(ScheduledEvent.last.schedulable_id).to eq meal.id
      expect(ScheduledEvent.last.dog_id).to eq dog.id
    end

    it "returns 201 and renders the Scheduled Event attributes" do
      post :create, scheduled_event: { start_time: "2017-01-01 08:00:00 -0800", end_time: "2017-01-01 08:15:00 -0800", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: meal.id, dog_id: dog.id }
      expect(response.status).to eq 201

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to be_present
      expect(response_json["start_time"]).to eq "2017-01-01 08:00:00 -0800"
      expect(response_json["end_time"]).to eq "2017-01-01 08:15:00 -0800"
      expect(response_json["date"]).to eq "2017-01-01"
      expect(response_json["schedulable_type"]).to eq "Meal"
      expect(response_json["schedulable_id"]).to eq meal.id
      expect(response_json["dog_id"]).to eq dog.id
    end
  end
end
