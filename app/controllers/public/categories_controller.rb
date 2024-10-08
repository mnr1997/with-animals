class Public::CategoriesController < PublicController
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      @categories = Category.page(params[:page])
      render :index
    end
  end
  
  def index
    @category = Category.new
    @categories = Category.page(params[:page])
  end
  
  def show
    @category = Category.find(params[:id])
    @posts = @category.category_posts
                      .preload(:favorites, :user)
                      .page(params[:page])
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
