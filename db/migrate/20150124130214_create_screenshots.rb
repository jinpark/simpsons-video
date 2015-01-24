class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :attachment
      t.integer :season
      t.integer :episode_number
      t.float :time

      t.timestamps
    end
  end
end
