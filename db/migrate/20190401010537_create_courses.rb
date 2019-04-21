class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :city
      t.integer :province_id
      t.integer :country_id
      t.string :zip
      t.string :url

      t.timestamps
    end
  end
end
