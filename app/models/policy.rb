# == Schema Information
#
# Table name: policies
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Policy < ActiveRecord::Base
  attr_accessible :number
end
