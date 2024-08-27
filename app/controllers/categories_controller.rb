class CategoriesController < ApplicationController
  before_action :require_login

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_expense_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
