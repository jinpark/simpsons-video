class AddDataUrItoScreenshot < ActiveRecord::Migration
  def change
  	  	add_column :screenshots, :datauri, :text
  end
end
