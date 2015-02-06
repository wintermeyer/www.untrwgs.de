class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :gender, index: true
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
    add_foreign_key :users, :genders
  end
end
