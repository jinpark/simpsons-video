class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :season
      t.integer :episode_number
      t.string :thumbnail
      t.string :path
      t.string :filename

      t.timestamps
    end
  end
end
