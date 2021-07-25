class PipelinesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pipeline, only: [:show, :edit, :update, :destroy]

  # GET /pipelines
  def index
    @pagy, @pipelines = pagy(Pipeline.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @pipelines.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @pipelines.load
  end

  # GET /pipelines/1
  def show
  end

  # GET /pipelines/new
  def new
    @pipeline = Pipeline.new
  end

  # GET /pipelines/1/edit
  def edit
  end

  # POST /pipelines
  def create
    @pipeline = current_user.pipelines.new(pipeline_params)
    @pipeline.account = current_account

    if @pipeline.save
      redirect_to @pipeline, notice: "Pipeline was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pipelines/1
  def update
    if @pipeline.update(pipeline_params)
      redirect_to @pipeline, notice: "Pipeline was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pipelines/1
  def destroy
    @pipeline.destroy
    redirect_to pipelines_url, notice: "Pipeline was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pipeline
    @pipeline = Pipeline.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def pipeline_params
    params.require(:pipeline).permit(:name, :account_id, :user_id, sources_attributes: [:intent, :type, :url])
  end
end
