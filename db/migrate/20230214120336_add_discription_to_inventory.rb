class AddDiscriptionToInventory < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :discription, :string
  end
end
