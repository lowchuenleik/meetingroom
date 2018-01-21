class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :venue
	before_create :randomize_id
	
	attr_accessor :date_range

	def all_day_reservation?
	  self.start == self.start.midnight && self.end == self.end.midnight ? true : false
	end

	private

	def randomize_id
		begin
			self.id = SecureRandom.random_number(1_000_000)
		end while Reservation.where(id: self.id).exists?
	end

	def reservation_bought
		Reservation.find_by_id(self.reservation_id)
	end

	def description
		"Transaction ID: #{id} -- #{user.email} just bought a #{reservation_bought.name} for $#{total.to_s}, from #{merchant.title}"
	end

	def make_charge()

		charge = Stripe::Charge.create({
		  # Total Amount user will be charged (in cents)
		  amount: (total * 100).to_i,
		  # Currency of charge
		  currency: 'gbp',
		  # the applicant users Stripe Customer ID
		  # expect format of "cus_0xxXxXXX0XXxX0"
		  # customer: user.stripe_customer_id,
		  source: token,
		  # Description of charge
		  description: description,
		  # Final Destination of charge (host standalone account)
		  # Expect format of acct_00X0XXXXXxxX0xX
		  destination: 'acct_1BkE4zF7Uf64alcA',

		  }
		)
		# if the charge is successful, we'll receive a response in the charge object
		# We can then query that object via charge.paid
		# if true we can update our attribute
		# byebug
		update_attributes(paid: true, stripe_charge: charge.id) if charge.paid?
		begin

		rescue => e
			body = e.json_body
			err  = body[:error]

			puts "Status is: #{e.http_status}"
			puts "Type is: #{err[:type]}"
			puts "Charge ID is: #{err[:charge]}"
			# The following fields are optional
			puts "Code is: #{err[:code]}" if err[:code]
			puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
			puts "Param is: #{err[:param]}" if err[:param]
			puts "Message is: #{err[:message]}" if err[:message]
		end

	end
end
