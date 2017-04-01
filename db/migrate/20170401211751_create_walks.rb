class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.string :location
      t.boolean :leash_required?
      t.belongs_to :dog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
