class CreateSampleGroups < ActiveRecord::Migration
  def change
    create_table :sample_groups do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
