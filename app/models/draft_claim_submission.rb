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

class DraftClaimSubmission < ClaimSubmission
  establish_connection("draft_#{Rails.env}")

  def self.draft(base_instance)
    base_instance.becomes(self.name.constantize)
  end
end
