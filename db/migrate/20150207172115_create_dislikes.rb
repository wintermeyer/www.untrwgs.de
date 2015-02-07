class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.references :dislikeable, polymorphic: true, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :dislikes, :users
  end
end
