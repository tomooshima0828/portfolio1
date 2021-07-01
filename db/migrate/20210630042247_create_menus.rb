class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :item
      t.integer :item_number
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
