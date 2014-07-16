class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :number
      t.date :filed_on
      t.integer :amount_cents
      t.references :policy

      t.timestamps
    end
    add_index :claims, :policy_id
  end
end
