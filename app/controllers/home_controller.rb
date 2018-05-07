class HomeController < ApplicationController
  def index
  	@events = Event.all
  	@users = User.all
    @attendees = current_user.events
  end
end
