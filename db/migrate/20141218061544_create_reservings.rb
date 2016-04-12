class CreateReservings < ActiveRecord::Migration
  def change
    create_table :reservings do |t|
      t.references :reservation, null: false
      t.references :member, null: false
      t.references :library, null: false
      t.references :book, null: false

      t.datetime :reserve_date,

      t.timestamps
    end
  end
end
