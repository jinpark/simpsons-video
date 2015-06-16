ActiveAdmin.register Screenshot do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :season, :episode_number, :time, :tags
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
	show do
	    attributes_table do
	      row :id
	      row :season
	      row :episode_number
	      row :time
	      row :tags
	      row :image do |post|
	        image_tag post.attachment
	      end
	    end
	    active_admin_comments
	end

end
