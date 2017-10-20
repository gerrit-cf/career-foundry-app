class RegistrationController < AuthenticationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      RegistrationMailer.welcome(@user).deliver_now
      flash[:success] = 'You successfully signed up. Please sign in to continue.'
      redirect_to sign_in_path
    else
      flash.now[:error] = 'Sign up was not successful. Please check your inputs.'
      render :new
    end
  end

  private

  def registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation).tap do |parameters|
      parameters[:email].downcase!
    end
  end
end
