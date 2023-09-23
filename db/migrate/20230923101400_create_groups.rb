class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false

      t.timestamps
    end
  end
end
