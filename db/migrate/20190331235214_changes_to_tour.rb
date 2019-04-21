class ChangesToTour < ActiveRecord::Migration[5.1]
  def change
  	remove_column :tours, :province


  end
end
