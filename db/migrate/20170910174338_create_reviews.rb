class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string  :comment
      t.integer :user_id,         null: false
      t.integer :reviewable_id,   null: false
      t.integer :reviewable_type, null: false

      t.timestamps
    end

    add_index :reviews, :reviewable_id
    add_index :reviews, :user_id
  end
end
