class AnimalsController < ApplicationController
  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
      user = User.find(params[:user_id])
      redirect_to user_animals_path(user.id)
    else
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @animals = @user.animals
  end

  def show
    @user = User.find(params[:user_id])
    @animal = Animal.find(params[:id])
    @posts = @animal.posts
  end

  def edit
    @user = User.find(params[:user_id])
    @animal = Animal.find(params[:id])
  end
  
  def update
    user = User.find(params[:user_id])
    animal = Animal.find(params[:id])
    if animal.update(animal_params)
      redirect_to user_animal_path(user_id: animal.user_id, id: animal.id)
    else
      render :edit
    end
  end
  
  private

  def animal_params
    params.require(:animal).permit(:image, :name, :sex, :age, :character)
  end
end
