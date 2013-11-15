class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
