class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.date :date_of_birth
      t.string :position
      t.string :email
      t.string :phone
      t.date :contract_start
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
