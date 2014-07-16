class ClaimantsController < ApplicationController
  # GET /claimants
  # GET /claimants.json
  def index
    @claimants = Claimant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @claimants }
    end
  end

  # GET /claimants/1
  # GET /claimants/1.json
  def show
    @claimant = Claimant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @claimant }
    end
  end

  # GET /claimants/new
  # GET /claimants/new.json
  def new
    @claimant = Claimant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @claimant }
    end
  end

  # GET /claimants/1/edit
  def edit
    @claimant = Claimant.find(params[:id])
  end

  # POST /claimants
  # POST /claimants.json
  def create
    @claimant = Claimant.new(params[:claimant])

    respond_to do |format|
      if @claimant.save
        format.html { redirect_to @claimant, notice: 'Claimant was successfully created.' }
        format.json { render json: @claimant, status: :created, location: @claimant }
      else
        format.html { render action: "new" }
        format.json { render json: @claimant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /claimants/1
  # PUT /claimants/1.json
  def update
    @claimant = Claimant.find(params[:id])

    respond_to do |format|
      if @claimant.update_attributes(params[:claimant])
        format.html { redirect_to @claimant, notice: 'Claimant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @claimant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claimants/1
  # DELETE /claimants/1.json
  def destroy
    @claimant = Claimant.find(params[:id])
    @claimant.destroy

    respond_to do |format|
      format.html { redirect_to claimants_url }
      format.json { head :no_content }
    end
  end
end
