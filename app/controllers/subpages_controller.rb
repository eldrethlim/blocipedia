class SubpagesController < ApplicationController

  def new
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = @wiki.pages.friendly.find(params[:page_id])
    @subpage = @page.subpages.build
    authorize @subpage
  end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = @wiki.pages.friendly.find(params[:page_id])
    @subpage = current_user.subpages.build(subpage_params)
    @subpage.page = @page
    @subpage.wiki = @wiki

    authorize @subpage
    if @subpage.save
      redirect_to [@wiki, @page, @subpage], notice: "Sub-page created."
    else
      flash[:error] = "Error creating sub-page. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = @wiki.pages.friendly.find(params[:page_id])
    @subpage = @page.subpages.friendly.find(params[:id])
  end

  def edit
    subpage_var

    title = @page.name
  end

  def update
    subpage_var

    if @subpage.update_attributes(subpage_params)
      flash[:notice] = "Your sub-page was updated."
      redirect_to [@wiki, @page, @subpage]
    else
      flash[:error] = "Error saving sub-page. Please try again."
      render :edit
    end
  end

  def destroy
    subpage_var

    title = @subpage.name

    if @subpage.destroy
      flash[:notice] = "\"#{title}\" was deleted."
      redirect_to @page
    else
      flash[:error] = "Error deleting sub-page. Please try again."
      render :show
    end
  end

  private

  def subpage_var
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = @wiki.pages.friendly.find(params[:page_id])
    @subpage = @page.subpages.friendly.find(params[:id])
    authorize @subpage
  end

  def subpage_params
    params.require(:subpage).permit(:name, :body, :page_id, :wiki_id)
  end
end
