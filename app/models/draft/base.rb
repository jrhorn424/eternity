module Draft::Base
  extend ActiveSupport::Concern

  module ClassMethods
    def retrieve_connection
        Draft::Base::DraftableProxy.retrieve_connection
    end
  end

  class DraftableProxy < ActiveRecord::Base
    def self.abstract_class?
      true
    end

    establish_connection("draft_" + Rails.env.to_s)
  end
end
