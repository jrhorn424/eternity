module Draft
  # Draft.new(BusinessObject.find(id)) => [#<DraftBusinessObject ...>] # with all associated objects saved)
  #
  # At bootup, store a list of objects that are draftable.
  # When we make a draft, draft all objects at the same time.

  # def initialize(base_instance)
  #   self.class.create_drafts(base_instance)
  # end

  # def self.create_drafts(base_instance)
  #   base_instance.create_draft
  #   DRAFTABLES.each do |d|
  #     base_instance.send d.downcase
  #   end
  # end
  def self.new_draft(claim)
    draft_claim = claim.create_draft
    claim.policy.create_draft
    claim.claim_submissions.each { |cs| cs.create_draft }
    claim.claimants.each { |c| c.create_draft }
    draft_claim.save
    draft_claim
  end

  def self.publish(draft_claim)
    currently_published = Claim.find(draft_claim.id)
    pub_diff = draft_claim.diff(currently_published).inject({}) do |h, (key, value)|
      h[key] =  value[0]
      h
    end
    currently_published.update_attributes(pub_diff)
  end
end
