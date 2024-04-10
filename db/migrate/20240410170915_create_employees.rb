class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :age
      t.string :position
      t.date :birthday
      t.string :contact
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
