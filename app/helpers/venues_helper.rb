module VenuesHelper
	def google_static(middle)
		"https://maps.googleapis.com/maps/api/staticmap?size=640x640&center=#{middle}&zoom=17&key=AIzaSyD-H8fH3GiQaK8K8Sj0Q2GY6EA6Blrtt98"
	end

	def google_embed_view(loc)
		"https://www.google.com/maps/embed/v1/view?key=AIzaSyD-H8fH3GiQaK8K8Sj0Q2GY6EA6Blrtt98
          &center=#{loc}&zoom=14"
    end
end
