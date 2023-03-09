# frozen_string_literal: true

class CategoriesController < BaseController
  def index
    @categories = Category.order(title: :asc)
  end
end
