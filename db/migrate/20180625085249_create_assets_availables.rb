class CreateAssetsAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :assets_availables do |t|
      t.string :quantity

      t.timestamps
    end
  end
end
