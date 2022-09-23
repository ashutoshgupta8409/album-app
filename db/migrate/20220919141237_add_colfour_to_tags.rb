class AddColfourToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :album_id, :integer
  end
end
