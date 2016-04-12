class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.string :body
      t.date :released_at, null: false
      t.references :library
      t.timestamps
    end
  end
end
