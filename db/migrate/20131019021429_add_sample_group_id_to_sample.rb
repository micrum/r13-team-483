class AddSampleGroupIdToSample < ActiveRecord::Migration
  def change
    add_column :samples, :sample_group_id, :integer
  end
end
