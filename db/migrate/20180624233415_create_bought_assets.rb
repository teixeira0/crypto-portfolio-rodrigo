class CreateBoughtAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :bought_assets do |t|
      t.string :asset_id
      t.string :asset_name
      t.float :asset_value
      t.float :quantity
      t.float :total_value

      t.timestamps
    end
  end
end
