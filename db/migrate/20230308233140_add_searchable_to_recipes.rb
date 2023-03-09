class AddSearchableToRecipes < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE recipes
        ADD COLUMN searchable_ingredients tsvector GENERATED ALWAYS AS (to_tsvector('english', coalesce(ingredients, '') || ' ')) STORED;
      CREATE INDEX searchable_ingredients_idx ON recipes USING GIN (searchable_ingredients);
    SQL
  end

  def down
    remove_column :recipes, :searchable_ingredients
    remove_index :recipes, name: :searchable_ingredients_idx
  end
end