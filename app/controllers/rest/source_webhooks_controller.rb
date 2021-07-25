class Rest::SourceWebhooksController < Rest::BaseWebhooksController
    before_action :verify_user_permissions
    before_action :create_or_update_schema
    
    # POST /leads
    def input
      
      event = UnprocessedEvent.new(payload: params, stream_status: "unprocessed", remote_ip: request.remote_ip, source_id: source_from_token.id)
      
      if event.save
        render json: event
      else
        render json: {status: "error", code: 4000, message: "Unable to save request"}
      end
      
    end

    private
  
    def lead_params
      params.require(:source_webhook).permit(:first_name, :last_name, :email, :phone, :address, :address2, :city, :address_state, :zip_code, :user_id, :source_id, :account_id, :marketing_accepted)
    end

    def verify_user_permissions
        unless source_from_token.pipeline.account.users.exists?(user_from_token.id)
            render json: {errors: "invalid permissions"}
        end
    end
    
    def create_or_update_schema
      field_set = FieldSet.where(source_id: source_from_token.id).first_or_create  
      payload = params[:source_webhook]
        
      payload.each do |key, value|
        event_field = EventField.where(field_set_id: field_set.id, field_name: key).first_or_create

        if value.is_a?(Hash)
          event_field.update(data_type: "parent", example_value: nil, last_used_at: Time.now)

          create_sub_field(value, event_field)
        else
          event_field.update(data_type: value.class.to_s.downcase, example_value: value.to_s, last_used_at: Time.now)
        end
      end
    end


    def create_sub_field(value, parent)
      value.each do |key, value|
        sub_event_field = EventField.where(field_set_id: parent.field_set.id,parent_field_id: parent.id, field_name: key).first_or_create
             
        if value.is_a?(Hash)
          sub_event_field.update(data_type: "parent", example_value: nil, last_used_at: Time.now)
          create_sub_field(value, sub_event_field)
        else
          sub_event_field.update(data_type: value.class.to_s.downcase, example_value: value.to_s, last_used_at: Time.now)
        end
      end     
    end

end