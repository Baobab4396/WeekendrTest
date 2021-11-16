class CreateWeekSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :week_schedules do |t|
      t.string :shop_name
      t.string :schedule

      t.timestamps
    end
  end
end
