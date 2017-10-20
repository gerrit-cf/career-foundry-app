module RequestSpecHelper
  def sign_in(user)
    params = {
      user: {
        email: user.email,
        password: user.password
      }
    }

    post '/sign_in', params: params
  end
end
