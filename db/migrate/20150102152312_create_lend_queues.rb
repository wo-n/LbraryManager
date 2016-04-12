class CreateLendQueues < ActiveRecord::Migration
  def change
    create_table :lend_queues do |t|
      t.references :reservation, null: false
      t.references :member, null: false
      t.references :library, null: false
      t.references :book, null: false
      t.timestamps
    end
  end
end
