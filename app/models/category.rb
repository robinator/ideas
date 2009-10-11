class Category < ActiveRecord::Base
  has_many :ideas
  stampable
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :creator_id
  acts_as_ferret :fields => [ :name ] if RAILS_ENV == 'production'
  
  
  def self.new_from_name(name, creator_id)
    c = Category.first(:conditions => {:creator_id => creator_id, :name => name})
    unless c
      c = Category.new(:name => name, :creator_id => creator_id)
      c.save
    end
    c
  end
end