class WikisController < ApplicationController

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def edit
    @user = User.all
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    name = @wiki.name
    
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "#{name} settings have been updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    name = @wiki.name

    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_path
    else
      flash[:error] = "There was a problem deleting this wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:name, :body, :public, collaborator_ids: [])
  end
end
