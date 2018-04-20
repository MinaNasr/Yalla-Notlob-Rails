module ApplicationCable
  class Channel < ActionCable::Channel::Base
  
    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    # end

    # private
    #   def find_verified_user
    #     token = request.params[:token]
    #     user_id = JsonWebToken.decode(token)[:user_id]
    #     if verified_user = User.find_by(id: user_id)
    #       verified_user
    #     else
    #       reject_unauthorized_connection
    #     end
    #   end
  end
end
