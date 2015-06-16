class AddSubtitleTextToScreenshot < ActiveRecord::Migration
  def change
  	add_column :screenshots, :subtitle_text, :text
  end
end
