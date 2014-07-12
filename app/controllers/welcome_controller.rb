class WelcomeController < ApplicationController
  def index
    if current_user
      @user = current_user.id
    end
  end

  def about
  end
end
