class CollaborationsController < ApplicationController

  def collaborate
    Collaboration.update_all({:wiki_id}, {id: params[:user_ids]})
    redirect_to edit_wiki_path
  end
end
