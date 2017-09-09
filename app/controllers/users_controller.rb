class UsersController < ApplicationController
  before_action :authenticate!
  before_action :set_user

  def show
    authorize @user, :show?
  end

  def update
    @user.assign_attributes(user_params)
    authorize @user, :update?

    if @user.save
      flash[:success] = 'You successfully updated your information.'
      redirect_to user_path
    else
      flash.now[:error] = 'Your information could not be updated. Please check your inputs.'
      render :show
    end
  end

  private

  def user_params
    # First name, last name and email should not be editable by user
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end
