class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup(user)
    @subject = "Thanks for signing up!"
    @body = { :user => user }
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