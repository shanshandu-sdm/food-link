class CreateFoodDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :food_donations do |t|
      t.bigint :restaurant_id, null: false
      t.bigint :charity_id
      t.integer :quantity
      t.integer :status
      t.string :note
      t.text :review
      t.datetime :available_at
      t.timestamps
    end
  end
end
