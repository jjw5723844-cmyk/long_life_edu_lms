class CreateFacilities < ActiveRecord::Migration[8.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.text :description
      t.integer :capacity
      t.integer :fee
      t.string :image_url
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
