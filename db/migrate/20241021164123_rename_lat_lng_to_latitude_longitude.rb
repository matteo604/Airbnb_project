class RenameLatLngToLatitudeLongitude < ActiveRecord::Migration[7.1]
  def change
    change_table(:properties) do |t|
    t.rename(:lat, :latitude)
    t.rename(:lng, :longitude)
    end
  end
end
