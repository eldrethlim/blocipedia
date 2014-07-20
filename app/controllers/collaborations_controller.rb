class CollaborationsController < ApplicationController
  def add_collaborators

    @collaboration = Collaboration.new

      if @collaboration.save
        redirect_to edit_wiki_path, :notice => "Collaborators for #{name} updated."
      else
        flash[:error] = "There was a problem updating the collaborators for #{name}. Please try again."
        redirect_to edit_wiki_path
      end
  end

  def collab_params
    params.require(:collaboration).permit(:wiki_id, :user_id)
  end

end
