class CreateScheduleItems < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_items do |t|
      t.string :shop_name
      t.integer :day_id
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end
