class EventFieldsController < ApplicationController
before_action :set_event_field

def update

    @source = @event_field.field_set.source
    
    if params[:event_field][:target_field_name].blank? 
      @event_field.target_data_type = ""
    else 
      @event_field.target_data_type = Lead.columns_hash[params[:event_field][:target_field_name]].type
    end
    
    if @event_field.update(event_field_params)
      
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_field
    @event_field = EventField.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_field_params
    params.require(:event_field).permit(:target_field_name, :target_data_type)
  end

end
