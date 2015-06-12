class AddSubtitlePathAndSubtitleFilenameToVideo < ActiveRecord::Migration
  def change
  	add_column :videos, :subtitle_path, :string
  	add_column :videos, :subtitle_filename, :string
  end
end
