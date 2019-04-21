class AddAddressToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :address, :string

  end
end
