class WalksController < ApplicationController

  def create
    walk = Walk.create(walk_params)
    render :json walk, status: :created
  end

  private
  def walk_params
    params.require(:walk).permit(:location, :leash_required?, :dog_id)
  end

end
