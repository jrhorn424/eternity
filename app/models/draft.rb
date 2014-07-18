class Draft

  # def tree
  #  [
  #    Policy,
  #    Claim,
  #    #etc.
  #  ]
  # end

  # def graph
  #   all_activerecord_objects.each do |attribute|
  #     #find draftable bits
  #   end.inject(Array.new) do |array, attribute|
  #     # let's make a linked list
  #     # [ root, [child, [grandchild, grandchild], child, [grandchild]]]
  #     #make tree data structure to pass in to method that does draft createion work
  #     attribute
  #   end
  # end
  #
  # def make(root)
  #   root.draft
  #   root.attributes.draftable.each do |draftable|
  #     root.draftable.name.to_s  make(draftable)
  #   end
  #
  # end

  def self.make(claim)
    draft_claim = DraftClaim.draft(claim)
    draft_claim.policy = DraftPolicy.draft(claim.policy)
    claim.claim_submissions.each_with_index do |claim_submission, index|
      draft_claim.claim_submissions[index] = DraftClaimSubmission.draft(claim_submission)
    end
    claim.claimants.each_with_index do |claimant, index|
      draft_claim.claimants[index] = DraftClaimant.draft(claimant)
    end
    draft_claim
  end

  def self.make_savable(draft_claim)
    draft_claim.instance_variable_set("@new_record",true)
    draft_claim.policy.instance_variable_set("@new_record", true)
    draft_claim.claim_submissions.each { |cs| cs.instance_variable_set("@new_record", true) }
    draft_claim.claimants.each { |c| c.instance_variable_set("@new_record", true) }
    draft_claim
  end

  def self.save_all(draft_claim)
    draft_claim.claimants.each { |c| c.save }
    draft_claim.claim_submissions.each { |c| c.save }
    draft_claim.policy.save
    draft_claim.save
    # draft_claim
  end
end
