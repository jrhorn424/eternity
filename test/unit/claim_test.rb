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

require 'test_helper'

class ClaimTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
