class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|

      t.string :title
      t.status :integer

      t.integer :iterations_count
      t.float :sys_time
      t.float :user_time
      t.float :real_time
      t.integer :memory

      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
