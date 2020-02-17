class DashboardsController < ApplicationController
  def show

  end

  def edit
    @user = User.find(user_params)
  end

  def update
    @user = User.find(params[:id])
    @user.update(task_params)
    redirect_to dashboards_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
