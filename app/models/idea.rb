class Idea < ActiveRecord::Base
  belongs_to :category
  stampable
  
  attr_accessor :category_name
  
  validates_presence_of :name
  acts_as_ferret :fields => [ :name, :body, :inspiration, :application, :when_to_execute ] if RAILS_ENV == 'production'
  
  def category_name=(name)
    unless name.blank?
      c = Category.new_from_name(name, User.stamper) # user User.stamper because creator_id is not set
      self.category = c
    end
  end
end
