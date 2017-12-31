ActiveAdmin.register Reservation do
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

	permit_params :name, :price, :start, :end, :date

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :name
			f.input :price
			f.input :start
			f.input :end
			f.input :date
		end
		f.actions
	end

	index do
		selectable_column
		id_column
		column :name
		column :price
		column :start
		column :end
		column :date
		actions
	end


end
