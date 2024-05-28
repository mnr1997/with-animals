class CreateAnimalPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_posts do |t|
      t.bigint :post_id, null: false
      t.bigint :animal_id, null: false
      t.timestamps
    end
  end
end
