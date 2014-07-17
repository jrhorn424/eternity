# == Schema Information
#
# Table name: claims
#
#  id           :integer          not null, primary key
#  number       :string(255)
#  filed_on     :date
#  amount_cents :integer
#  policy_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Claim < ActiveRecord::Base
  belongs_to :policy
  has_many :affidavits
  has_many :claimants, through: :claim_submissions

  attr_accessible :amount_cents, :filed_on, :number, :policy_id
end
