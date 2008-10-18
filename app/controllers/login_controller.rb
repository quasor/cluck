class LoginController < ApplicationController
# GET /login?username=
# http://ham64:8080/?rurl=http://localhost:3000/login?u=
	def login
		if params[:u].blank?
			redirect_to "http://ham64:8080/?rurl=http://#{request.env['HTTP_HOST']}/login?u="
			#render :inline => "<%= debug request.env%>"
		else
			username = /[a-z,\\\-\_,0-9]+/.match(params[:u].gsub("SEA\\",""))
			if username
				logger.info username[0]
				session[:username] = username[0] 
				redirect_to "/"
			else
				render :text => 'unable to get username'
			end
		end	
	end
	def logout
		session.delete
		redirect_to "/"
	end
end
