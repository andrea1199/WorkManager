class CreateDaySchedulings < ActiveRecord::Migration[7.1]
  def change
    create_table :day_schedulings do |t|
      t.date :date
      t.time :start_work
      t.time :end_work
      t.time :start_break
      t.time :end_break


      t.timestamps
    end
  end
end
