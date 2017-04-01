class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :food
      t.string :portion
      t.belongs_to :dog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
