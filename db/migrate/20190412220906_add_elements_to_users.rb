class AddElementsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :datetime
    add_column :users, :ovga_team, :boolean
    add_column :users, :rogc_team, :boolean
    add_column :users, :gender_boy, :boolean
    add_column :users, :gender_girl, :boolean
    add_column :users, :category_jun, :boolean
    add_column :users, :category_juv, :boolean
    add_column :users, :category_ban, :boolean
    add_column :users, :category_pee, :boolean
    add_column :users, :category_ato, :boolean

  end
end
