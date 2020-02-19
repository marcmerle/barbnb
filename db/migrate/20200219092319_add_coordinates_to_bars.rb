class AddCoordinatesToBars < ActiveRecord::Migration[6.0]
  def change
    add_column :bars, :latitude, :float
    add_column :bars, :longitude, :float
  end
end
