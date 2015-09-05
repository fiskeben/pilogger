class EventsController < ApplicationController

  def index
    @events = Event.in_duration(params[:from], params[:to])
    @current_value = @events.last.value unless @events.empty?
  end
end
