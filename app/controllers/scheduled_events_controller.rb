class ScheduledEventsController < ApplicationController
  #postman can't verify CSRF token authenticity
  skip_before_action :verify_authenticity_token

  def show
    sorted_schedule = get_scheduled_events
    render json: sorted_schedule
  end

  def create
    new_event = ScheduledEvent.new(schedule_params)
    if !overlapping?(new_event)
      new_event.save
      render json: new_event, status: :created
    else
      render json: {error: "There was an error saving the event"}
    end
  end

  private
  def schedule_params
    params.permit(:start_time, :end_time, :date, :schedulable_type, :schedulable_id, :dog_id)
  end

  def overlapping?(new_event)
    days_events = ScheduledEvent.where("dog_id = ? AND date = ?", params[:dog_id], new_event.date)
    if !days_events.nil?
      days_events.each do |event|
        if (new_event.start_time - event.end_time) * (event.start_time - new_event.end_time) > 0
          p "There is already an event scheduled at that time"
          return true
        end
      end
    end
    false
  end

  def get_scheduled_events
    days_events = ScheduledEvent.where("dog_id = ? AND date = ?", params[:dog_id], params[:date])
    schedule = []
    days_events.each do |event|
      event_hash = {
        type: event.schedulable_type,
        start_time: event.start_time,
        end_time: event.end_time,
        date: event.date,
      }
      event_data = event.schedulable
      event_data_hash = event_data.map(&:attributes)
      event_hash[:type_description] = event_data_hash
      schedule << event_hash
    end
    schedule.sort_by { |hash| hash[:start_time] }
  end

end
