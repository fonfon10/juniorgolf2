class AddAcronymToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :acronym, :string
  end
end
