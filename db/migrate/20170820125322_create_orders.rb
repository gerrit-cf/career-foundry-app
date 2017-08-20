class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id,    null: false, index: true
      t.integer :product_id, null: false, index: true
      t.decimal :total
    end
  end
end
