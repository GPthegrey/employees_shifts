class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :day_of_week
      t.string :turno
      t.boolean :bank_holiday, default: false
      t.integer :number_employees, default: 2

      t.timestamps
    end
  end
end
