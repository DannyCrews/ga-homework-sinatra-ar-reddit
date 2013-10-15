class CreateComments < ActiveRecord::Migration
def up
    create_table :comments do |t|
      t.string   :title
      t.string   :author, default: "anonymous"
      t.text     :body
      t.integer  :up_votes, default: 0
      t.integer  :down_votes, default: 0
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end


