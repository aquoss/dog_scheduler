class DogsController < ApplicationController
  #postman can't verify CSRF token authenticity
  skip_before_action :verify_authenticity_token

  def create
    dog = Dog.create(dog_params)
    render json: present_dog(dog), status: :created
  end

  private
  def dog_params
    params.permit(:name)
  end

  def present_dog(dog)
    {
      id: dog.id,
      name: dog.name
    }
  end
end
