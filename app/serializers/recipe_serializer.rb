# frozen_string_literal: true

class RecipeSerializer < Blueprinter::Base
  fields :title,
         :cooktime,
         :preptime,
         :rating,
         :author

  association :category, blueprint: CategorySerializer
  field :rating do |obj|
    obj.rating.to_f
  end

  field :ingredients do |obj|
    JSON.parse(obj.ingredients)
  end
end