class CreateBoughtAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :bought_assets do |t|
      t.string :bought_id
      t.string :bought_name
      t.float :bought_value

      t.timestamps
    end
  end
end
