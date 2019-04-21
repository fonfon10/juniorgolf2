class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :tour_id
      t.integer :course_id
      t.boolean :gender_boy
      t.boolean :gender_girl
      t.boolean :category_jun
      t.boolean :category_juv
      t.boolean :category_ban
      t.boolean :category_pee
      t.boolean :category_ato
      t.integer :level_id
      t.integer :days
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :reg_deadline
      t.boolean :qual_required
      t.text :comments

      t.timestamps
    end
  end
end
