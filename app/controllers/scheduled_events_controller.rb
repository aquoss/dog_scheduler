class ScheduledEventsController < ApplicationController

  def create
    new_event = ScheduledEvent.new(schedule_params)
    if !overlapping?(new_event)
      new_event.save
    end
  end

  private
  def schedule_params
    params.require(:scheduled_event).permit(:start_time, :end_time, :date, :schedulable_type, :schedulable_id, :dog_id)
  end

  def overlapping?(new_event)
    days_events = ScheduledEvents.find(dog_id: params[:dog_id]).where(date: new_event.date)
    days_events.each do |event|
      if (new_event.start_time - event.end_time) * (event.start_time - new_event.end_time) > 0
        return true
      end
    end
    false
  end
  
end
