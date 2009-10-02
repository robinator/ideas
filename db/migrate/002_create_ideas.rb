class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.integer :category_id
      t.integer :parent_id
      t.string :name
      t.text :body
      t.string :inspiration
      t.string :application
      t.string :when_to_execute
      t.boolean :executed, :default => false
      t.string :access, :default => 'private', :length => 10
      
      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end