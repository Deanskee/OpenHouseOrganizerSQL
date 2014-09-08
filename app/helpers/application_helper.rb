module ApplicationHelper

    def current_user
        @current_user ||= session[:remember_token] && User.where(id: session[:remember_token]).first
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

    def format_phone(phone, mobile=false)
    return phone if format.blank?
    groupings = format.scan(/d+/).map { |g| g.length }
    groupings = [3, 3, 4] unless groupings.length == 3
    ActionController::Base.helpers.number_to_phone(
      phone,
      :groupings => groupings,
      :delimiter => format.reverse.match(/[^d]/).to_s
    )
  end
end
