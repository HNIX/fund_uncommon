class SourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_pipeline
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  def index
    @sources = @pipeline.sources

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @pipelines.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @sources.load
  end

  def show
  end

  def new
    @source = @pipeline.sources.build
  end

  def edit
  end

  def create
    @source = @pipeline.sources.build(source_params)
    @source.user = current_user

    respond_to do |format|
      if @source.save
        format.html { redirect_to pipeline_source_path(@pipeline.id, @source.id), notice: 'Source was successfully created.' }
        format.json { render :show, status: :created, location: @source }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @source.destroy
     respond_to do |format|
      format.html { redirect_to pipeline_path(@pipeline), notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to pipeline_source_path(@pipeline.id, @source.id), notice: 'Source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def restream
    @source = @pipeline.sources.find(params[:source_id])
    
    @source.unprocessed_events.where(:stream_status => "streaming error").each do |event|
      ProcessEventJob.perform_later(event.id)
    end

    respond_to do |format|
      format.js
    end
  end 

  private

    def set_source
        @source = @pipeline.sources.find(params[:id])
    end
    
    def get_pipeline
      @pipeline = Pipeline.find(params[:pipeline_id])
    end

    def source_params
      params.require(:source).permit(:name, :private, :desc, :url, :pipeline_id, :source_type, :webhook_token)
    end

end