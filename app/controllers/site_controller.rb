class SiteController < ApplicationController
  #before_filter :store_location
  before_filter :check_administrator_role, :only => [:admin]
  
  def about
    @title = " "
  end
  
  def feedback
  
  end

  def admin
    @usercount = User.count
    @ideacount = Idea.count
    @categorycount = Category.count
  end

end