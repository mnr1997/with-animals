class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.bigint :user_id, null: false
      t.bigint :category_id
      t.string :name
      t.integer :sex
      t.string :age
      t.string :character

      t.timestamps
    end
  end
end
