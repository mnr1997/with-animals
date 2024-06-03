class CategoriesController < ApplicationController
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      @categories = Category.all
      render :index
    end
  end
  
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @posts = @category.category_posts
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
