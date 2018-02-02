class UserMailer < ApplicationMailer
	include ActiveModel::Validations
	default from: 'giant.health.tech.team@gmail.com'

	validates :terms, acceptance: true
 
	def welcome_email(user, email)
		@user = user
		@url  = 'http://example.com/login'
	    mail(to: email, subject: 'Join us at Hang!')
	end
end
