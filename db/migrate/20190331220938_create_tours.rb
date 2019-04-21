class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string :name
      t.integer :country_id
      t.string :province

      t.timestamps
    end
  end
end
