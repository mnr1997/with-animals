class AnimalsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @animal = Animal.new
    @categories = Category.all
  end

  def create
    @animal = current_user.animals.new(animal_params)
    if @animal.save
      redirect_to user_animals_path(current_user)
    else
      @categories = Category.all
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @animals = @user.animals
  end

  def show
    @animal = Animal.find(params[:id])
    @posts = @animal.posts
  end

  def edit
    @animal = Animal.find(params[:id])
    @categories = Category.all
  end
  
  def update
    animal = Animal.find(params[:id])
    if animal.update(animal_params)
      redirect_to animal_path(animal)
    else
      @categories = Category.all
      render :edit
    end
  end
  
  private

  def animal_params
    params.require(:animal).permit(:animal_image, :name, :sex, :age, :character, :category_id)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
