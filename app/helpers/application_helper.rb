module ApplicationHelper

	def current_user
    	if session[:remember_token]
    		@current_user ||= User.find(session[:remember_token])
    	else
    		false
    	end
  	end

  	def authenticate_user
	    if !self.current_user
	      redirect_to new_sessions_path
	    end
  	end

end