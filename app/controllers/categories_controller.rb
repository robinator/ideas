class CategoriesController < ApplicationController
  before_filter :login_required, :except => [:show]
  
  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])
    unless current_user.has_access?(@category)
      flash[:error] = "You do not have permission to access this category."
      redirect_to(ideas_url)
      return
    end
    @ideas = current_user.ideas(@category.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    unless current_user.has_access?(@category)
      flash[:error] = "You do not have permission to access this category."
      redirect_to(ideas_url)
      return
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])
    unless current_user.has_access?(@category)
      flash[:error] = "You do not have permission to access this category."
      redirect_to(ideas_url)
      return
    end
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    unless current_user.has_access?(@category)
      flash[:error] = "You do not have permission to access this category."
      redirect_to(ideas_url)
      return
    end
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
end
