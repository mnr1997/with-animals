class Admin::CategoriesController < AdminController
  
  def index
    @categories = Category.all.page(params[:page])
    if params[:name].present?
      @categories = @categories.name_search(params[:name])
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy!
    redirect_to admin_categories_path, notice: "カテゴリーを削除しました。"
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
