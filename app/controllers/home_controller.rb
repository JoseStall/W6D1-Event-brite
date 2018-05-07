class HomeController < ApplicationController
  def index
  	@events = Event.all
  	@users = User.all
  	if user_signed_in?
    	@attendees = current_user.events
	end
  end
end
