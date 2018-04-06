class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
    
    include ExceptionHandler
  
    # [...]
    private
    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' ,code:401}, status: 401 unless @current_user
    end
end
