class Category < ActiveRecord::Base
  has_many :ideas
  stampable
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :creator_id
  acts_as_ferret :fields => [ :name ]
  
end
