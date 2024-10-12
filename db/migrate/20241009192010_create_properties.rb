class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.decimal :price_per_night
      t.string :title
      t.text :description
      t.string :location
      t.integer :max_guests
      t.string :property_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
