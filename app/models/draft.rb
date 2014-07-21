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
    currently_published.update_attributes(diff_obj(draft_claim, currently_published)))

    published_claimants = currently_published.claimants
    draft_claimants = draft_claim.claimants
    publish_multis(draft_claimants, published_claimants, Claimant)

  end

  def self.publish_multis(drafts, published, multi_type)
    published.select { |c| drafts.none? { |d| d.id ==  c.id}}.each { |dc| dc.delete}
    drafts.each do |draft|
      if(draft.id < 0)
        new_multi = draft.becomes(mult_type)
        new_multi.id = nil
        new_multi.instance_variable_set(@'new_record', true)
        new_multi.save
      else
        published = published.select {|p| p.id = draft.id}
        published.update_attributes(diff_obj(draft, published))
      end
    end
  end

  def self.diff_obj(draft, published)
    pub_diff = draft_claim.diff(currently_published).inject({}) do |h, (key, value)|
      h[key] =  value[0]
      h
    end
  end
end
