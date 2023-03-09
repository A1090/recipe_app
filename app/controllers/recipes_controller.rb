# frozen_string_literal: true

class RecipesController < BaseController
  before_action :set_recipe, only: :show

  def search
    search_terms = search_params['query'].split('/,|\s/')
    category = search_params['category_id']

    @recipes = Recipe.paginate(pagination_params).search(category, search_terms)
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
