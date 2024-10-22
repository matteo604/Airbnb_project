class RenameLatLngToLatitudeLongitude < ActiveRecord::Migration[6.1]
  def change
    change_table :properties do |t|
      if column_exists?(:properties, :lat) && !column_exists?(:properties, :latitude)
        t.rename :lat, :latitude
      end
      if column_exists?(:properties, :lng) && !column_exists?(:properties, :longitude)
        t.rename :lng, :longitude
      end
    end
  end
end
