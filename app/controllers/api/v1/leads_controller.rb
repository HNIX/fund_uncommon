class Api::V1::LeadsController < Api::BaseController
    before_action :set_source_and_account
    before_action :verify_user_permissions

    # GET /leads
    def index
      @leads = Lead.all
      # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
      # Calling @leads.any? in the view will use the loaded records to check existence instead of making an extra DB call.
      render json: @leads
    end

    # GET /leads/1
    def show
      @lead = Lead.find(params[:id])
      render json: @lead
    end

    # POST /leads
    def create
      @lead = Lead.new(lead_params)
      @lead.source = @source
      @lead.account = @account
      @lead.user = user_from_token

      if @lead.save
        render json: {
        lead: {
          id: @lead.id,
          first_name: @lead.first_name, 
          last_name: @lead.last_name
        }
      }
      else
        render json: {errors: @lead.errors}
      end
    end

    private
  
    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :address, :address2, :city, :address_state, :zip_code, :user_id, :source_id, :account_id, :marketing_accepted)
    end

    def source
      @source = Source.find_by(id: params[:source_id])
    end
    
    def set_source_and_account
      if source.present?
        @account = @source.pipeline.account
      end
    end

    def verify_user_permissions
      unless @account.users.exists?(user_from_token.id)
        render json: {errors: "invalid permissions"}
      end
    end
    
  end
  