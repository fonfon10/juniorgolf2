class CreateCompetitions < ActiveRecord::Migration[5.1]
  def change
    create_table :competitions do |t|
      t.integer :tournament_id
      t.integer :status_id
      t.integer :user_id

      t.timestamps
    end
  end
end
