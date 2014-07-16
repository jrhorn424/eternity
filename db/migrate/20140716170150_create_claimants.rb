class CreateClaimants < ActiveRecord::Migration
  def change
    create_table :claimants do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
