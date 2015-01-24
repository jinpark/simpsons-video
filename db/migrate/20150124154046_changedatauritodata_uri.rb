class ChangedatauritodataUri < ActiveRecord::Migration
  def change
  	rename_column :screenshots, :datauri, :data_uri
  end
end
