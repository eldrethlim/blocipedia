class SubpagesController < ApplicationController

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Wiki.pages.find(params[:page_id])
    @subpage = Subpage.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = Wiki.pages.find(params[:page_id])
    @subpage.page = @page
    @subpage = @page.subpage
    @subpage = current_user.subpages.build(subpage_params)

    authorize @wiki
    if @subpage.save
      redirect_to @subpage, notice: "Sub-page created."
    else
      flash[:error] = "Error creating sub-page. Please try again."
      render :new
    end
  end

  def show
    subpage_var
  end

  def edit
    subpage_var

    title = @page.title
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

    title = @subpage.title

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
    @wiki = Wiki.find(params[:wiki_id])
    @page = Wiki.pages.find(params[:page_id])
    @subpage = Subpage.find(params[:id])
    authorize @wiki
  end

  def subpage_params
    params.require(:subpage).permit { :name, :body, :page_id }
  end
end
