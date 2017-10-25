class SessionController < AuthenticationController
  skip_before_action :verify_unauthenticated, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to redirect_path || root_path
    else
      flash.now[:error] = 'Username or password are invalid.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password).tap do |parameters|
      parameters[:email].downcase! if parameters[:email].present?
    end
  end

  def redirect_path
    session[:redirect_path]
  end
end
