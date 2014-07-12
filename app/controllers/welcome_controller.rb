class WelcomeController < ApplicationController
  def index
    #This is the controller
    if current_user
      @user = current_user.id
    end
  end

  def about
  end
end
