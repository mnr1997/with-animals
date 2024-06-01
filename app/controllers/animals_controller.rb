class AnimalsController < ApplicationController
  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    user = User.find(params[:user_id])
    @animals = user.animals
  end

  def show
    @user = User.find(params[:user_id])
    @animal = Animal.find(params[:id])
  end

  def edit
  end

  private

  def animal_params
    params.require(:animal).permit(:image, :name, :sex, :age, :character)
  end
end
