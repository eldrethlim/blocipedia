class PagesController < ApplicationController

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = current_user.pages.build(page_params)
    @page.wiki = @wiki


    authorize @wiki
    if @page.save
      redirect_to @page, notice: "Page created."
    else
      flash[:error] = "Error creating page. Please try again."
      render :new
    end
  end

  def show
    @page = Page.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:wiki_d])
    @page = Page.find(params[:id])
    authorize @wiki
    if @page.update_attributes(page_params)
      flash[:notice] = "Your page was updated."
      redirect_to [@wiki, @page]
    else
      flash[:error] = "Error saving page. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])

    title = @page.title
    authorize @wiki
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
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
    authorize @wiki
  end

  def page_params
    params.require(:page).permit(:title, :body, :wiki_id)
  end
end
