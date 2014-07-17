class PagesController < ApplicationController

  def new
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.new
    authorize @page
  end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = current_user.pages.build(page_params)
    @page.wiki = @wiki

    authorize @page
    if @page.save
      redirect_to [@wiki, @page], notice: "Page created."
    else
      flash[:error] = "Error creating page. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
  end

  def edit
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
  end

  def update
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
    if @page.update_attributes(page_params)
      flash[:notice] = "Your page was updated."
      redirect_to [@wiki, @page]
    else
      flash[:error] = "Error saving page. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])

    title = @page.title
    authorize @page
    if @page.destroy
      flash[:notice] = "\"#{title}\" was deleted."
      redirect_to @wiki
    else
      flash[:error] = "Error deleting page. Please try again."
      render :show
    end
  end

  private

  def page_var
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
  end

  def page_params
    params.require(:page).permit(:name, :body, :wiki_id)
  end
end
