class CollaborationsController < ApplicationController
  def add_collaborators
    @wiki = current_user.wikis.find(params[:id])

    if @wiki.add_collaborators.save(@wiki, user_id: params[:user_id])
      redirect_to current_user
    else
    end
  end

end
