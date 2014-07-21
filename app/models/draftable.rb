module Draftable
  extend ActiveSupport::Concern

  included do
  end

  # Object.find(id).new_draft => [#<DraftObject ...>]
  def new_draft
    self.becomes(draft_class)
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
      draft_class.where(id: id)
    end

  private
    def draft_class
      "Draft#{self.name}".constantize
    end
  end

private

  def draft_class
    "Draft#{self.class.name}".constantize
  end
end
