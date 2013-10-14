class RedditTable < ActiveRecord::Migration
  def up
    create_table 		:reddits do |t|
      t.string   		:title
      t.text   			:story
      t.string			:author
      t.integer  		:up_votes, default: 0
      t.integer  		:down_votes, default: 0
      t.timestamps
    end
  end

  def down
    drop_table reddits
  end
end
