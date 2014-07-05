class WikisController < ApplicationController
  def index
  end
  
  def new
  end

  def create
    @wiki = current_user.posts.build(params.require(:wiki).permit(:title, :body))
    authorize @wiki
  end

  def view
  end

  def edit
  end

  def print
  end

  def help
  end

end
