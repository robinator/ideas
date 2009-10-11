class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && verify_recaptcha(:model => @user) && @user.save
    if success && @user.errors.empty? 
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      if current_user.id == @user.id
        format.html
      else
        flash[:error] = "You do not have permission to edit this user."
        format.html { redirect_to(ideas_url) }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      flash[:error] = "You do not have permission to edit this user."
      redirect_to(ideas_url)
      return
    end    
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User information was successfully updated.'
        format.html { redirect_to(ideas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def ideas
    @user = User.find_by_login(params[:login])
    @ideas = @user.nil? ? [] : @user.public_ideas
  end
end
