class AddCancelledByToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :cancelled_by, :int
  end
end
