class CreateOperations < ActiveRecord::Migration[7.0]
  def change
    create_table :operations do |t|
      t.string :name
      t.float :amount
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    create_table :categories_operations, id: false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :operation, null: false, foreign_key: true
    end
  end
end
