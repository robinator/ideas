class SiteController < ApplicationController
  #before_filter :store_location
  #before_filter :check_administrator_role, :only => [:admin, :recycle_bin]
  
  def index

  end

  def about
    @title = " "
  end
  
  def feedback
    user = User.first
    UserMailer.deliver_signup_notification(user)
    
  end

end