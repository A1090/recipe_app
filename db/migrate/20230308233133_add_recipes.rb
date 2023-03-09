class AddRecipes < ActiveRecord::Migration[7.0]
  def up
    create_table :recipes do |t|
      t.string     :title, null: false
      t.integer    :cooktime, null:false
      t.integer    :preptime, null: false
      t.text       :ingredients, null: false
      t.decimal    :rating
      t.belongs_to :category, foreign_key: true
      t.string     :author
      t.string     :image_link
      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
