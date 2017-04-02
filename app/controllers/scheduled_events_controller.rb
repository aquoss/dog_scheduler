class ScheduledEventsController < ApplicationController

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

  ## check if there is a conflicting event
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

  ## find scheduled events for a date and output in json format
  def get_scheduled_events
    days_events = ScheduledEvent.where("dog_id = ? AND date = ?", params[:dog_id], params[:date])
    schedule = []
    if !days_events.nil?
      formatted_schedule = format_events_for_api(days_events, schedule)
      schedule = formatted_schedule.sort_by {|hash| hash[:start_time]}
    end
    schedule
  end

  ## format data for scheduled_events api endpoint
  def format_events_for_api(events, schedule)
    events.each do |event|
      event_data = {
        type: event.schedulable_type,
        start_time: event.start_time,
        end_time: event.end_time,
        date: event.date,
      }
      event_type_data = event.schedulable.as_json
      type_description_data = remove_database_markers(event_type_data)
      event_data[:type_description] = type_description_data
      schedule << event_data
    end
    schedule
  end

  ## remove data from being displayed at the scheduled_events api endpoint
  def remove_database_markers(data)
    data.delete("updated_at")
    data.delete("created_at")
    data.delete("id")
    data.delete("dog_id")
    data
  end


end
