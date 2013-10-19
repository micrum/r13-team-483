class SampleGroupsController < ApplicationController

  before_action :set_sample_group, only: [:show, :edit]

  # GET /samples
  # GET /samples.json
  def index
    @sample_groups = SampleGroup.all
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
  end

  # GET /samples/new
  def new
    @sample_group = SampleGroup.new
  end

  # GET /samples/1/edit
  def edit
  end

  # POST /samples
  # POST /samples.json
  def create
    @sample_group = SampleGroup.new(sample_group_params)

    respond_to do |format|
      if @sample_group.save
        format.html { redirect_to @sample_group, notice: 'Sample was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sample_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @sample_group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sample_group
    @sample_group = SampleGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sample_group_params
    params[:sample_group]
  end

end