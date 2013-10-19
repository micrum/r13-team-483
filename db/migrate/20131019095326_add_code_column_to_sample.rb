class AddCodeColumnToSample < ActiveRecord::Migration
  def change
    add_column :samples, :code, :text
  end
end
