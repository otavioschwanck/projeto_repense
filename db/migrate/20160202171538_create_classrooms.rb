class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.references :student, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.date :entry_at

      t.timestamps null: false
    end
  end
end
