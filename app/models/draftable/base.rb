module Draftable::Base
  extend ActiveSupport::Concern

  # Object.find(id).new_draft => [#<DraftObject ...>]
  def new_draft
    self.becomes(self.draft_class)
  end

  # Object.find(id).create_draft => [#<DraftObject ...>]
  # Like #new_draft, but persists to the database.
  def create_draft
    draft = new_draft
    draft.instance_variable_set("@new_record", true)
    draft.save
    draft
  end

  module ClassMethods
    def draftable?
      true
    end

    def find_draft(id)
      draft_class.find(id)
    end

  private

    def draft_class_name
      "Draft#{self.name}"
    end

    def draft_class
      draft_class_name.constantize
    end
  end
end
