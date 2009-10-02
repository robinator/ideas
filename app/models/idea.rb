class Idea < ActiveRecord::Base
  belongs_to :category
  stampable
  
  attr_accessor :category_name
  
  validates_presence_of :name
  acts_as_ferret :fields => [ :name, :body, :inspiration, :application, :when_to_execute ]
  
  def category_name=(name)
    unless name.blank?
      c = Category.new(:name => name)
      c.save
      self.category = c
    end
  end
end
