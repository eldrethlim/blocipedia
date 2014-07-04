class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    @plans = Plan.all
  end

  def create
    @subscription = Subscription.new(plan_id: params[:plan_id])
    if @subscription.save_with_payment(params[:stripeToken], params[:stripeEmail])
      redirect_to @subscription, :notice => "Thank you for subscribing as a premium user!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
end