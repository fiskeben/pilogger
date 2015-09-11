class Api::EventsController < Api::ApiController
  #before_action :authenticate, except: [ :index ]
  before_action :load_event, except: [ :index, :create, :new ]

  def index
    @events = Event.in_duration(params[:from], params[:to])
    render json: @events
  end

  def show
    render json: @event
  end

  def new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      render json: @event
    else
      render plain: "Unable to save event", status: 422
    end
  end

  def update
    @event.update!(event_params)
    render json: @event
  end

  def destroy
    @event.destroy
    render nothing: true, status: 204
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :value, :occurred_at)
  end
end
