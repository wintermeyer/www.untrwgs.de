class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :abstract
      t.text :content
      t.integer :state
      t.integer :likes_count
      t.integer :dislikes_count

      t.timestamps null: false
    end
    add_foreign_key :posts, :users
  end
end
