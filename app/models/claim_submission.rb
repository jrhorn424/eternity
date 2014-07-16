class ClaimSubmission < ActiveRecord::Base
  belongs_to :claim
  belongs_to :claimant
end
