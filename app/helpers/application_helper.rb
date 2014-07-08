module ApplicationHelper

    def current_user
        @current_user ||= session[:remember_token] && User.find(session[:remember_token])
    end

    def signed_in?
        current_user
    end


    def login_required
    	unless current_user
    	  session[:redirect] = request.original_url
    	  redirect_to new_session_path
    	end
    end
end
