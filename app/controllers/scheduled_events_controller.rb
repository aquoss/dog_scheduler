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

  ## check if the dog already has an event scheduled at that time
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

  ## find scheduled events for a date and format for api endpoint
  def get_scheduled_events
    days_events = ScheduledEvent.where("dog_id = ? AND date = ?", params[:dog_id], params[:date])
    schedule = []
    if !days_events.nil?
      days_events.each do |event|
        event_hash = {
          type: event.schedulable_type,
          date: event.date,
          start_time: event.start_time,
          end_time: event.end_time,
        }
        event_data = event.schedulable.as_json
        event_hash[:type_description] = event_data
        schedule << event_hash
      end
      schedule = schedule.sort_by {|hash| hash[:start_time]}
    end
    schedule
  end


end
