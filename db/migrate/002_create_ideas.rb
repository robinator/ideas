class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.integer :user_id
      t.integer :parent_id
      t.string :name
      t.text :body
      t.string :category
      t.string :inspiration
      t.string :application
      t.string :when_to_execute
      t.boolean :executed, :default => false
      
      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end