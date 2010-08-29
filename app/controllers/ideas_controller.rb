class IdeasController < ApplicationController
  before_filter :login_required, :except => [:show]
  
  def index
    @ideas = current_user.ideas
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
      format.js { render :json => @ideas }
    end
  end

  def show
    @idea = Idea.find(params[:id])
    
    respond_to do |format|
      if @idea.access == 'public' || current_user.has_access?(@idea)
        format.html
        format.js { render :json => @idea }
      else
        flash[:error] = "You do not have permission to access this idea."
        format.html { redirect_to(ideas_url) }
      end
    end
  end

  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if current_user.has_access?(@idea)
        format.html
      else
        flash[:error] = "You do not have permission to access this idea."
        format.html { redirect_to(ideas_url) }
      end
    end
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    @idea = Idea.new(params[:idea])
    
    respond_to do |format|
      if @idea.save
        flash[:notice] = 'Idea was successfully created.'
        format.html { redirect_to(ideas_url) }
        format.xml  { render :xml => @idea, :status => :created, :location => @idea }
        format.js  { render :json => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
        format.js  { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.xml
  def update
    @idea = Idea.find(params[:id])
    unless current_user.has_access?(@idea)
      flash[:error] = "You do not have permission to access this idea."
      redirect_to(ideas_url)
      return
    end    
    
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        flash[:notice] = 'Idea was successfully updated.'
        format.html { redirect_to(ideas_url) }
        format.xml  { head :ok }
        format.js  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
        format.js  { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.xml
  def destroy
    @idea = Idea.find(params[:id])
    unless current_user.has_access?(@idea)
      flash[:error] = "You do not have permission to access this idea."
      redirect_to(ideas_url)
      return
    end
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
      format.js  { head :ok }
    end
  end

end