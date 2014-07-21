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

  def edit
    @plans = Plan.all
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

    if @subscription.update_card(card_info)
      redirect_to current_user, :notice => "Your payment details have been updated"
    else
      flash[:error] = "There was a problem updating your payment details. Please try again or drop us an email for assistance."
      redirect_to edit_subscription_path
    end
  end

  def update_subscription_plan
    @subscription = current_user.subscription

    if @subscription.change_subscription(params[:plan_stripe_id], params[:plan_id])
      redirect_to current_user, :notice => "Your subscription plan has been changed"
    else
      flash[:error] = "There was a problem changing your subscription plan. Please try again or drop us an email for assistance."
      redirect_to edit_subscription_path
    end
  end

  def cancel_subscription
    @subscription = current_user.subscription

    if @subscription.cancel_subscription
      redirect_to current_user, :notice => "Your subscription plan has been cancelled. We're sorry to see you go."
    else
      flash[:error] = "There was a problem cancelling your subscription plan. Please try again or drop us an email for assistance."
      redirect_to edit_subscription_path
    end
  end
end