require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  model_stamper
  
  has_many :ideas
  has_many :categories
  
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..50 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation
  attr_accessor :current_password

  after_create :deliver_signup_notification
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def categories
    Category.all(:conditions => {:creator_id => self.id})
  end

  def public_ideas
    Idea.all(:conditions => {:creator_id => self.id, :access => 'public'}, :order => 'created_at DESC')
  end

  def has_access?(object)
    object.creator_id == self.id
  end
  
  def ideas(category_id = nil)
    conditions = {:creator_id => self.id}
    conditions[:category_id] = category_id if category_id
    @ideas = Idea.all(:conditions => conditions, :order => 'created_at DESC')
  end
  
  def deliver_forgot_password
    new_password = rand(999999999)
    self.update_attributes(:password => new_password, :password_confirmation => new_password)
    
    UserMailer.deliver_forgot_password(self, new_password)
  end
  
  def deliver_signup_notification
    UserMailer.deliver_signup_notification(self)
  end
  
  protected

end
