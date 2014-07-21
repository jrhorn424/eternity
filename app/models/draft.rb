class Draft

  # Draft.new(BusinessObject.find(id)) => [#<DraftBusinessObject ...>] # with all associated objects saved)
  #
  # At bootup, store a list of objects that are draftable.
  # When we make a draft, draft all objects at the same time.
  #
  # ...
  class << self
    def models
      Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize.name }
    end

    # these must be activerecord models, no way around it
    def draftables
      models.select { |m| m.constantize.draftable? unless m.match 'Draft' }
    end
  end



  # def self.make(claim)
  #   draft_claim = DraftClaim.draft(claim)
  #   draft_claim.policy = DraftPolicy.draft(claim.policy)
  #   claim.claim_submissions.each_with_index do |claim_submission, index|
  #     draft_claim.claim_submissions[index] = DraftClaimSubmission.draft(claim_submission)
  #   end
  #   claim.claimants.each_with_index do |claimant, index|
  #     draft_claim.claimants[index] = DraftClaimant.draft(claimant)
  #   end
  #   draft_claim
  # end

  # def self.make_savable(draft_claim)
  #   draft_claim.instance_variable_set("@new_record",true)
  #   draft_claim.policy.instance_variable_set("@new_record", true)
  #   draft_claim.claim_submissions.each { |cs| cs.instance_variable_set("@new_record", true) }
  #   draft_claim.claimants.each { |c| c.instance_variable_set("@new_record", true) }
  #   draft_claim
  # end

  # def self.save_all(draft_claim)
  #   draft_claim.claimants.each { |c| c.save }
  #   draft_claim.claim_submissions.each { |c| c.save }
  #   draft_claim.policy.save
  #   draft_claim.save
  # end

end
