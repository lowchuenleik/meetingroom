class UserMailer < ApplicationMailer
	default from: 'giant.health.tech.team@gmail.com'
 
	def welcome_email(user, email)
		@user = user
		@url  = 'http://example.com/login'
	    mail(to: email, subject: 'Join us at Hang!')
	end
end
