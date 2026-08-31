class AddCategoryToNotices < ActiveRecord::Migration[8.1]
  def change
    add_column :notices, :category, :string
  end
end
