class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :started_at
      t.datetime :finished_at
      t.string :note
      t.string :selector_stylist_request
      t.string :status_event_request
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
