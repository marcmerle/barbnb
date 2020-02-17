class CreateBars < ActiveRecord::Migration[6.0]
  def change
    create_table :bars do |t|
      t.string :name
      t.string :address
      t.integer :capacity
      t.integer :opening_start
      t.integer :opening_end
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
