class AddTagsToScreenshot < ActiveRecord::Migration
  def change
  	add_column :screenshots, :tags, :text
  end
end
