class CreateItemTagRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :item_tag_relations do |t|
      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
