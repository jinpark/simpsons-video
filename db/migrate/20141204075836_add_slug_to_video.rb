class AddSlugToVideo < ActiveRecord::Migration
  def change
  	add_column :videos, :slug, :string, :unique => true
  end
end
