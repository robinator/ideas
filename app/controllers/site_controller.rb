class SiteController < ApplicationController
  #before_filter :store_location
  #before_filter :check_administrator_role, :only => [:admin, :recycle_bin]
  
  def about
    @title = " "
  end
  
  def feedback
  
  end

end