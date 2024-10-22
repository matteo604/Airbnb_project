class AddLngLatToProperty < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :lng, :float
    add_column :properties, :lat, :float
  end
end
