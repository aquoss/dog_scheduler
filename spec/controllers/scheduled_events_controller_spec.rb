require 'rails_helper'

RSpec.describe ScheduledEventsController, type: :controller do
  before :each do
    @dog = Dog.create(name:"Brutus")
    @meal = Meal.create(food: "Kibbles n Bits", portion: "2 cups", dog_id: @dog.id)
  end

  describe "POST#create" do
    it "creates a Scheduled Event for a dog" do
      expect do
        post :create, { start_time: "2017-01-01 08:00:00 +0000", end_time: "2017-01-01 08:15:00 +0000", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: @meal.id, dog_id: @dog.id }
      end.to change { ScheduledEvent.count }.by 1

      expect(ScheduledEvent.last.start_time.to_time.to_s).to eq "2017-01-01 08:00:00 +0000"
      expect(ScheduledEvent.last.end_time.to_time.to_s).to eq "2017-01-01 08:15:00 +0000"
      expect(ScheduledEvent.last.date.to_s).to eq "2017-01-01"
      expect(ScheduledEvent.last.schedulable_type).to eq "Meal"
      expect(ScheduledEvent.last.schedulable_id).to eq @meal.id
      expect(ScheduledEvent.last.dog_id).to eq @dog.id
    end

    it "returns 201 and renders the Scheduled Event attributes" do
      post :create, { start_time: "2017-01-01 08:00:00 +0000", end_time: "2017-01-01 08:15:00 +0000", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: @meal.id, dog_id: @dog.id }
      expect(response.status).to eq 201

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to be_present
      expect(response_json["start_time"].to_time.to_s).to eq "2017-01-01 08:00:00 +0000"
      expect(response_json["end_time"].to_time.to_s).to eq "2017-01-01 08:15:00 +0000"
      expect(response_json["date"]).to eq "2017-01-01"
      expect(response_json["schedulable_type"]).to eq "Meal"
      expect(response_json["schedulable_id"]).to eq @meal.id
      expect(response_json["dog_id"]).to eq @dog.id
    end
  end

  describe 'PUT#update' do
    let(:scheduled_event) { ScheduledEvent.create(start_time: "2017-01-01 11:35:00 +0000", end_time: "2017-01-01 11:45:00 +0000", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: @meal.id, dog_id: @dog.id)}

    it "updates a scheduled event" do
      put :update, { dog_id: @dog.id, event_id: scheduled_event.id, start_time: "2017-01-01 11:40:00 +0000", end_time: "2017-01-01 11:55:00 +0000" }
      scheduled_event.reload

      expect(scheduled_event.start_time.to_time.to_s).to eq "2017-01-01 11:40:00 +0000"
      expect(scheduled_event.end_time.to_time.to_s).to eq "2017-01-01 11:55:00 +0000"
    end

    it "returns 200 and renders the updated event" do
      put :update, { dog_id: @dog.id, event_id: scheduled_event.id, start_time: "2017-01-01 11:40:00 +0000", end_time: "2017-01-01 11:55:00 +0000" }
      expect(response.status).to eq 200

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to eq scheduled_event.id
      expect(response_json["start_time"].to_time.to_s).to eq "2017-01-01 11:40:00 +0000"
      expect(response_json["end_time"].to_time.to_s).to eq "2017-01-01 11:55:00 +0000"
      expect(response_json["date"]).to eq "2017-01-01"
      expect(response_json["schedulable_type"]).to eq "Meal"
      expect(response_json["schedulable_id"]).to eq @meal.id
      expect(response_json["dog_id"]).to eq @dog.id

    end
  end

  describe 'DELETE#destroy' do
    let(:scheduled_event) { ScheduledEvent.create(start_time: "2017-01-01 08:00:00 +0000", end_time: "2017-01-01 08:15:00 +0000", date: "2017-01-01", schedulable_type: "Meal", schedulable_id: @meal.id, dog_id: @dog.id)}

    it "deletes a scheduled event" do
      expect {
        delete :destroy, { dog_id: @dog.id, event_id: scheduled_event.id }
      }.to change{ ScheduledEvent.count }.by(0)
    end

    it "returns 200 and renders the deleted event attributes" do
      delete :destroy, { dog_id: @dog.id, event_id: scheduled_event.id }
      expect(response.status).to eq 200

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to eq scheduled_event.id
      expect(response_json["start_time"].to_time.to_s).to eq "2017-01-01 08:00:00 +0000"
      expect(response_json["end_time"].to_time.to_s).to eq "2017-01-01 08:15:00 +0000"
      expect(response_json["date"]).to eq "2017-01-01"
      expect(response_json["schedulable_type"]).to eq "Meal"
      expect(response_json["schedulable_id"]).to eq @meal.id
      expect(response_json["dog_id"]).to eq @dog.id

    end
  end

end
