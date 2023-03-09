# frozen_string_literal: true

class RecipesController < BaseController
  before_action :set_recipe, only: :show

  def index
    @recipes = Recipe.all.order(rating: :desc)
  end

  def search
    search_terms = search_params['query'].split('/,|\s/')
    category = search_params['category_id']

    @recipes = if search_terms.empty?
                Recipe.includes(:category).paginate(pagination_params) .filter_by_category(category)
              else
                Recipe.includes(:category).paginate(pagination_params) .filter_by_category(category).search_ingredients(search_terms)
              end
  end

  def show
    @recipe
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def search_params
      params.permit(:query, :category_id)
    end

    def pagination_params
      { page: params[:page] || 1, per_page: params[:per_page] || 30 }
    end
end
