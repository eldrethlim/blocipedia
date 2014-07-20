class CollaborationsController < ApplicationController
  def add_collaborators
    @wiki = current_user.wikis.find(params[:id])
    name = @wiki.name

    if @wiki.add_collaborators.save(@wiki, user_id: params[:user_id])
      redirect_to edit_wiki_path, :notice => "Collaborators for #{name} updated."
    else
      flash[:error] = "There was a problem updating the collaborators for #{name}. Please try again."
      redirect_to edit_wiki_path
    end
  end

end
