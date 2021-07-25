class ProcessEventJob < ApplicationJob
    queue_as :default

    def perform(event_id)
       
        event = UnprocessedEvent.find(event_id)
        source = event.source
        account = source.pipeline.account
        user = source.pipeline.user

        if source.has_valid_field_mapping?
            
            @fields = source.field_set.event_fields
            
            hash = {}
            hash[:source_id] = source.id
            hash[:account_id] = account.id
            hash[:user_id] = user.id

            def traverse_fields(mapped_field, sub_value)
                sub_value.each do |key, value|
                    mapped_sub_field = @fields.where(field_name: key, parent_field_id: mapped_field.id).first
    
                    if value.is_a?(Hash)
                        traverse_fields(mapped_sub_field, value)
                    else
                        hash["#{mapped_sub_field.target_field_name}"] = value
                    end
                end
            end
            
            event.payload["source_webhook"].each do |key, value|
                mapped_field = @fields.where(field_name: key, parent_field_id: nil).first
                
                if value.is_a?(Hash)
                    traverse_fields(mapped_field, value)
                else
                    hash["#{mapped_field.target_field_name}"] = value
                end

            end
            
            lead = Lead.where(hash).first_or_create

            if lead.valid?
                event.update(stream_status: "processed")
            end
         
        else 
            event.update(stream_status: "streaming error")
        end 
       
    end  
end