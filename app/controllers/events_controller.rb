class EventsController < ApplicationController
  def index
    @events = Event.all
    @users = User.all
    if user_signed_in?
      @attendees = current_user.events
    else
      @attendees
    end
  end

	def new
    @event =Event.new
    flash[:success] = "vous avez bien crée un event"
  end

  def index
    @events = Event.all
    @users = User.all
  end

  def create
    Event.create(:description => params[:event][:description], :date => params[:event][:date], :place => params[:event][:place], :price => params[:event][:price], :creator_id => current_user.id)
    @event = Event.last
        flash[:success] = "vous avez bien crée un event"

  end

  def show
    @event = Event.find(params[:id])
    @user = User.all
    @b = @event.users
        flash[:success] = "vous avez bien crée un event"


  end
  def showid
    @event = Event.find(params[:id])
    @user = User.all
    @b = @event.users
  end



  def edit
    a = Event.find(params[:id])
    b = User.find(current_user.id)

    if a.price == 0
     a.users << b
     redirect_to root_path

    end
    @amount = a.price * 100
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
      )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount ,
      :description => '#{amount}',
      :currency    => 'eur'
      )
    a.users << b
    flash[:success] = 'Votre paiement a bien été pris en compte'
    redirect_to root_path


  rescue Stripe::CardError => e
    flash[:error] = e.message


  end  
end
