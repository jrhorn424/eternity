# == Schema Information
#
# Table name: claimants
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Claimant < ActiveRecord::Base
  attr_accessible :first_name, :last_name
end
