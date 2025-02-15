class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.integer :price
      t.text :about
      t.string :title

      t.timestamps
    end
  end
end
