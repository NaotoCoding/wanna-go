class CreateAcceptedInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :accepted_invites do |t|
      t.references :invite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
