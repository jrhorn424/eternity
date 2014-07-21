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

  self.reflections.each do |key, value|
    class_eval do
      # self.send value.macro, key.to_sym, value.options.merge!(class_name: "Draft#{key.to_s.singularize.camelize}".constantize )
    end
  end
end
