class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    @subscription = Subscription.new
    @plans = Plan.all
    authorize @subscription
  end

  def create
    @subscription = Subscription.new(plan_id: params[:plan_id])
    authorize @subscription

    if @subscription.save_with_payment(params[:stripeToken], params[:stripeEmail])
      redirect_to current_user, :notice => "Thank you for subscribing as a premium user!"
    else
      flash[:error] = "You are already subscribed as a premium user."
      render :show
    end
  end

  def edit_payment_details
    @subscription = current_user.subscription
  end

  def update_payment_details
    @subscription = current_user.subscription
    card_info = {
      number:    params[:number],
      exp_month: params[:date][:month],
      exp_year:  params[:date][:year],
      cvc:       params[:cvc]
    }

    if @subscription.update_card(@subscription, card_info)
      redirect_to current_user, :notice => "Your payment details have been updated"
    else
      flash[:error] = "There was a problem updating your payment details."
      render :show
    end
  end
end