class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.string :asset_id
      t.string :asset_name
      t.float :asset_value

      t.timestamps
    end
  end
end
