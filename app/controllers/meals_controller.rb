class MealsController < ApplicationController
  #postman can't verify CSRF token authenticity
  skip_before_action :verify_authenticity_token

  def create
    meal = Meal.create(meal_params)
    render json: meal, status: :created
  end

  private
  def meal_params
    params.permit(:food, :portion, :dog_id)
  end

end
