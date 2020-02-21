class CreateNilObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :nil_objects do |t|

      t.timestamps
    end
  end
end
