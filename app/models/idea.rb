class Idea < ActiveRecord::Base
  belongs_to :category
  stampable
  
  attr_accessor :category_name  
  validates_presence_of :name
  
  def category_name=(name)
    unless name.blank?
      c = Category.new_from_name(name, User.stamper) # use User.stamper because creator_id is not set
      self.category = c
    end
  end
end