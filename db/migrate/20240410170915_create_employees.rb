class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :age
      t.string :position
      t.date :birthday
      t.string :email
      t.string :phone
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
