class CreateTraces < ActiveRecord::Migration[6.0]
  def change
    create_table :traces do |t|
      t.json :coordinates

      t.timestamps
    end
  end
end
