class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      t.bigint :following_user_id, null: false
      t.bigint :followed_user_id, null: false

      t.timestamps
    end
  end
end
