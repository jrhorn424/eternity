class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :number

      t.timestamps
    end
  end
end
