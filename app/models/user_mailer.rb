class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup(user)
    @subject = "Thanks for signing up!"
    @body = { :user => user }
  end
  
  def snapshot(exception, trace, session, params, env, sent_on = Time.now)

      # [nazgum]: Setting the content-type like this did not work for me
      #@headers["Content-Type"] = "text/html" 

      # Setting the content-type like this does:
      content_type "text/html" 

      @recipients         = 'errors@flywheelnetworks.com'
      @from               = "<flux@flywheelnetworks.com>"
      @subject            = "[Error][AgentCRM] exception in #{env['REQUEST_URI']}" 
      @sent_on            = sent_on
      @body["exception"]  = exception
      @body["trace"]      = trace
      @body["session"]    = session
      @body["params"]     = params
      @body["env"]        = env
  end
  
  protected
    def setup(user)
      @recipients = "#{user.login} <#{user.email}>"
      @from        = "idealogue@madebylaw.com" # add angles eventually? TODO
#      @headers['Reply-to'] = @from
      @sent_on     = Time.now
      @content_type = "text/plain" # should be multipart? TODO http://api.rubyonrails.org/classes/ActionMailer/Base.html

      #debug purposes...
      unless ENV['RAILS_ENV'] == 'production'
        @recipients = "madebylaw@gmail.com"
      end
    end
end