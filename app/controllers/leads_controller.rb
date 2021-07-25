class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  # GET /leads
  def index
    @pagy, @leads = pagy(Lead.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @leads.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @leads.load
  end

  # GET /leads/1
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead, notice: "Lead was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to @lead, notice: "Lead was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
    redirect_to leads_url, notice: "Lead was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, :address, :address2, :city, :address_state, :zip_code, :user_id, :source_id, :account_id, :marketing_accepted)
  end
end
