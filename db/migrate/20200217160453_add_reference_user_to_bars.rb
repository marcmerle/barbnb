class AddReferenceUserToBars < ActiveRecord::Migration[6.0]
  def change
    add_reference :bars, :user, null: false, foreign_key: true
  end
end
