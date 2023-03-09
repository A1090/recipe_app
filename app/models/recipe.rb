# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                     :bigint           not null, primary key
#  author                 :string
#  cooktime               :integer          not null
#  image_link             :string
#  ingredients            :text             not null
#  preptime               :integer          not null
#  rating                 :decimal(, )
#  searchable_ingredients :tsvector
#  title                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  category_id            :bigint
#
# Indexes
#
#  index_recipes_on_category_id  (category_id)
#  searchable_ingredients_idx    (searchable_ingredients) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Recipe < ApplicationRecord
  include PgSearch::Model
  belongs_to :category, optional: true

  scope :filter_by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  
  pg_search_scope :search_ingredients, against: :ingredients, 
                                       using: { tsearch: { dictionary: 'english', any_word: true, tsvector_column: 'searchable_ingredients'} },
                                       :order_within_rank => 'recipes.rating DESC, recipes.cooktime ASC'
end
