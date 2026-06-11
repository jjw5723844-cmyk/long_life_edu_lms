class AddNameToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :name, :string
  end
end
