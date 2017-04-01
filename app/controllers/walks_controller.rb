class WalksController < ApplicationController
  #postman can't verify CSRF token authenticity
  skip_before_action :verify_authenticity_token

  def create
    walk = Walk.create(walk_params)
    render json: walk, status: :created
  end

  private
  def walk_params
    params.permit(:location, :leash_required?, :dog_id)
  end

end
