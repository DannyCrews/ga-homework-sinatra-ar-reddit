class AddRedditIdToComments < ActiveRecord::Migration
  def up
		add_column :comments, :reddit_id, :integer
	end

	def down
		remove_column :comments, :reddit_id, :integer
	end
end
