class CreateAvailables < ActiveRecord::Migration
  def change
    create_table :availables do |t|
      t.references :reservation, null: false
      t.references :member, null: false
      t.references :library, null: false
      t.references :book, null: false

      t.timestamps
    end
  end
end
