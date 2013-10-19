class AddErrorColumnToSample < ActiveRecord::Migration
  def change
    add_column :samples, :error, :text
  end
end
