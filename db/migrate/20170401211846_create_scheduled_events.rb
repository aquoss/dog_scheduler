class CreateScheduledEvents < ActiveRecord::Migration
  def change
    create_table :scheduled_events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.references :schedulable, polymorphic: true, index: true
      t.belongs_to :dog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
