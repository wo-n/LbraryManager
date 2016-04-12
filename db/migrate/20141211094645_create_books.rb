class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn, null: false #ISBN
      t.integer :quantity, null: false #冊数
      t.references :library #外部
      t.boolean :available, default: true #貸出可能状態かどうか

      t.timestamps
    end
  end
end
