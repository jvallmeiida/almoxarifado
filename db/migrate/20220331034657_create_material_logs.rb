class CreateMaterialLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :material_logs do |t|
      t.integer :status
      t.integer :quantity
      t.references :user
      t.references :material

      t.timestamps
    end
  end
end
