class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.text :caption, null: false
      t.integer :favorites_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.bigint :user_id, null: false
      t.timestamps
    end
  end
end
