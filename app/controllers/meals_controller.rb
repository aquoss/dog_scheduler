class MealsController < ApplicationController

  def create
    meal = Meal.create(meal_params)
    render json: meal, status: :created
  end

  private
  def meal_params
    params.permit(:food, :portion, :dog_id)
  end

end
