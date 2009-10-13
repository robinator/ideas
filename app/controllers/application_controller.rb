# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include Userstamp
  include AuthenticatedSystem
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected  

  def log_error(exception) 
    super(exception)
    begin
      if RAILS_ENV == 'production'
        UserMailer.deliver_snapshot(
          exception, 
          clean_backtrace(exception), 
          session.data, 
          params, 
          request.env)
      end
    rescue => e
      logger.error(e)
    end
  end
  
end
