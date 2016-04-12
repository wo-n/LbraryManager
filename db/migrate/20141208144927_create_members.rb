class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.references :library
      t.string :name
      t.string :email
      t.string :hashed_password
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end 
