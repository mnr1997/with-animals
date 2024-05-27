class AnimalsController < ApplicationController
  def new
    @animal = Animal.new
  end
  
  def create
    
  end

  def index
    @animals = Animal.all
  end

  def show
  end

  def edit
  end
  
  private
  
  def animal_params
    params.require(:animal).permit(:image, :name, :sex, :age, :character)
  end
end
