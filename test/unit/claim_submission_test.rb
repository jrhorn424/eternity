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

require 'test_helper'

class ClaimSubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
