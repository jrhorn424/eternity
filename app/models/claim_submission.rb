# == Schema Information
#
# Table name: claim_submissions
#
#  id          :integer          not null, primary key
#  claim_id    :integer
#  claimant_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ClaimSubmission < ActiveRecord::Base
  belongs_to :claim
  belongs_to :claimant
end
