# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include Userstamp
  include AuthenticatedSystem
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  
  def mobile_device?
    request.user_agent =~ /mobile|webOS/
  end
  
  helper_method :mobile_device?
  
  protected
  
  def check_administrator_role
    current_user && current_user.login == 'admin' ? true : access_denied
  end

end