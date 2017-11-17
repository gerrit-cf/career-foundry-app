module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_user
    end

    private

    def current_user
      current_user_from_session || reject_unauthorized_connection
    end

    def current_user_from_session
      user_id = request.env['rack.session'][:user_id]
      user_id ? User.find(user_id) : nil
    end
  end
end
