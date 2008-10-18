# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'bccf629ab6048b6f5c7e329c75c0abb4'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  def authorized
	admin?
  end
  def login_required
	authenticate
  end
  def admin?
	if current_user.nil?
		false
	else
		%(sanuras acoldham aprice ljasper).include? current_user
	end
  end
  def current_user
	session[:username]
  end

  private
	  USER_NAME = 'sandy'
	  PASSWORD = 'mttpower'
	  def authenticate
		session[:attempted_auth] = false
		if current_user.nil? and session[:attempted_auth] == false
			session[:attempted_auth] = true
			redirect_to login_path
		else
			#authenticate_or_request_with_http_basic do |user_name, password|
			#  session[:admin] = user_name == USER_NAME && password == PASSWORD
			#  username == USER_NAME && password == PASSWORD
			#end
		end
	  end

end
