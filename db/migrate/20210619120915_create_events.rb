class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :started_at
      t.datetime :finished_at
      t.string :note
      t.integer :selector_stylist_request, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
