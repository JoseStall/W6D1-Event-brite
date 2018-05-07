class EventsController < ApplicationController
	def new
    @event =Event.new
  end

  def create
    Event.create(:description => params[:event][:description], :date => params[:event][:date], :place => params[:event][:place], :price => params[:event][:price], :creator_id => current_user.id)
    @event = Event.last
  end

  def show
    @event = Event.find(params[:id])
    @user = User.all
    @b = @event.users

  end
  def showid
    @event = Event.find(params[:id])
    @user = User.all
    @b = @event.users
  end



  def edit
    a = Event.find(params[:id])
    b = User.find(current_user.id)
    a.users << b
    redirect_to root_path

    @amount = @a.price

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
      )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end
