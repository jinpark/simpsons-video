class RemoveDataUriFromScreenshots < ActiveRecord::Migration
  def change
    remove_column :screenshots, :data_uri
  end
end
