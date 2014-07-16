class Claim < ActiveRecord::Base
  belongs_to :policy
  has_many :affidavits
  has_many :claimants, through: :claim_submissions

  attr_accessible :amount_cents, :filed_on, :number, :policy_id
end
