class WikisController < ApplicationController

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    @wiki.update(body: "Edit your wiki now")
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:name, :body, :private)
  end
end
