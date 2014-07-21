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
require 'active_record/diff'

class Claim < ActiveRecord::Base
  include Draftable
  include ActiveRecord::Diff

  diff :exclude => [:updated_at]

  belongs_to :policy

  has_many :claimants, through: :claim_submissions
  has_many :claim_submissions

  attr_accessible :amount_cents, :filed_on, :number, :policy
end
