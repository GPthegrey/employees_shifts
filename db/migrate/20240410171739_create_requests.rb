class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
