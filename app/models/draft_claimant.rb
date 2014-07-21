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

class DraftClaimant < Claimant
  establish_connection("draft_#{Rails.env}")
end
