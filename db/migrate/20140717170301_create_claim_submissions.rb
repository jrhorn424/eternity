class CreateClaimSubmissions < ActiveRecord::Migration
  def change
    create_table :claim_submissions do |t|
      t.references :claim
      t.references :claimant

      t.timestamps
    end
    add_index :claim_submissions, :claim_id
    add_index :claim_submissions, :claimant_id
  end
end
