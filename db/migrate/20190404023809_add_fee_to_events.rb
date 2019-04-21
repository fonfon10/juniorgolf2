class AddFeeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :fee, :decimal
    add_column :tournaments, :url, :string
  end
end
