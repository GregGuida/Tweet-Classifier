class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :sentiment, :default => -1
      t.string :username, :default => :null
      t.string :text, :limit => 144
      t.integer :tid

      t.timestamps
    end
  end
end
