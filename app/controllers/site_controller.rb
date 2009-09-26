class SiteController < ApplicationController
  #before_filter :store_location
  #before_filter :check_administrator_role, :only => [:admin, :recycle_bin]
  
  def index

  end

  def about
    @title = " "
  end

  def help
    @title = " "
  end

  def admin
    @title = "AgentMachine - Admin Section"
  end
  
  def contact
    
  end
end