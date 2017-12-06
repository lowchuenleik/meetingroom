ActiveAdmin.register Booking do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	permit_params :name, :date, :client_id, :booking_time

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :name
			f.input :date
			f.input :client_id
			f.input :booking_time
		end
		f.actions
	end

	index do
		id_column
		column :name
		column :date
		column :client_id
		column :booking_time
		actions
	end


end
