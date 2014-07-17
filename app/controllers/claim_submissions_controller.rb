class ClaimSubmissionsController < ApplicationController
  # GET /claim_submissions
  # GET /claim_submissions.json
  def index
    @claim_submissions = ClaimSubmission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @claim_submissions }
    end
  end

  # GET /claim_submissions/1
  # GET /claim_submissions/1.json
  def show
    @claim_submission = ClaimSubmission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @claim_submission }
    end
  end

  # GET /claim_submissions/new
  # GET /claim_submissions/new.json
  def new
    @claim_submission = ClaimSubmission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @claim_submission }
    end
  end

  # GET /claim_submissions/1/edit
  def edit
    @claim_submission = ClaimSubmission.find(params[:id])
  end

  # POST /claim_submissions
  # POST /claim_submissions.json
  def create
    @claim_submission = ClaimSubmission.new(params[:claim_submission])

    respond_to do |format|
      if @claim_submission.save
        format.html { redirect_to @claim_submission, notice: 'Claim submission was successfully created.' }
        format.json { render json: @claim_submission, status: :created, location: @claim_submission }
      else
        format.html { render action: "new" }
        format.json { render json: @claim_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /claim_submissions/1
  # PUT /claim_submissions/1.json
  def update
    @claim_submission = ClaimSubmission.find(params[:id])

    respond_to do |format|
      if @claim_submission.update_attributes(params[:claim_submission])
        format.html { redirect_to @claim_submission, notice: 'Claim submission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @claim_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_submissions/1
  # DELETE /claim_submissions/1.json
  def destroy
    @claim_submission = ClaimSubmission.find(params[:id])
    @claim_submission.destroy

    respond_to do |format|
      format.html { redirect_to claim_submissions_url }
      format.json { head :no_content }
    end
  end
end
