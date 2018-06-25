class CreateLastUpdateds < ActiveRecord::Migration[5.2]
  def change
    create_table :last_updateds do |t|
      t.string :date

      t.timestamps
    end
  end
end
