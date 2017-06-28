class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
    @comic = Comic.find(params[:comic_id])
  end
  def create
    # binding.pry
    @comic = Comic.find(params[:comic_id])
    @subscription = Subscription.create(user: current_user, comic: @comic)
    redirect_to user_path(current_user)
  end
  def destroy

    @comic = Comic.find(params[:comic_id])
    @user = current_user
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to user_path(@user)
    flash[:notice] = "Subscription ended"
  end
  private
  def subscription_params
    params.require(:subscription).permit(:comic_id, :user_id)
  end

end