class AddUrlToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :url, :string
  end
end
