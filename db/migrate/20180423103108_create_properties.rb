class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name, index: true
      t.text :address, index: true
      t.numeric :no_of_bedrooms, default: 0
      t.numeric :no_of_bathrooms, default: 0
      t.decimal :size, index: true, default: 0
      t.timestamps
    end
  end
end
