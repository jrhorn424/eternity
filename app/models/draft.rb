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
    draft_claim.policy = claim.policy.create_draft
    claim.claimants.each { |c| draft_claim.claimants << c.create_draft }
    draft_claim.save
    draft_claim
  end

  def self.publish(draft_claim)
    Claim.transaction do

      if draft_claim.id > 0
        published_claim = Claim.find(draft_claim.id)
        published_claim.update_attributes(diff_obj(draft_claim, published_claim))
      else
        binding.pry
        published_claim = draft_claim.becomes(Claim)
        published_claim.id = nil
        published_claim.instance_variable_set('@new_record', true)
        published_claim.save
      end

      published_claimants = published_claim.claimants
      draft_claimants = draft_claim.claimants
      publish_multis(draft_claimants, published_claimants, Claimant)

      published_policy = published_claim.policy
      draft_policy = draft_claim.policy
      if published_policy.nil?
        published_policy = draft_claim.policy.becomes(Policy)
        published_policy.id = nil
        published_policy.instance_variable_set('@new_record', true)
        published_policy.save
      else
        published_policy.update_attributes(diff_obj(draft_policy, published_policy))
      end
      published_claim
    end
  end

  def self.publish_multis(drafts, published, multi_type)
    published.select { |p| drafts.none? { |d| d.id ==  p.id}}.each { |delpub| delpub.delete}
    drafts.each do |draft|
      if(draft.id < 0)
        new_multi = draft.becomes(multi_type)
        new_multi.id = nil
        new_multi.instance_variable_set('@new_record', true)
        new_multi.save
      else
        published = published.select {|p| p.id == draft.id}
        published.update_attributes(diff_obj(draft, published))
      end
    end
  end

  def self.diff_obj(draft, published)
    pub_diff = draft.diff(published).inject({}) do |h, (key, value)|
      h[key] =  value[0]
      h
    end
  end
end
