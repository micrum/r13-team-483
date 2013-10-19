class SampleGroupsController < ApplicationController

  before_action :set_sample_group, only: [:show, :edit, :run]


  def index
    @sample_groups = SampleGroup.last(6)
  end


  def show
  end


  def new
    @sample_group = SampleGroup.new
    2.times { @sample_group.samples.build }
  end


  def edit
  end


  def create
    @sample_group = SampleGroup.new(sample_group_params)

    respond_to do |format|
      if @sample_group.save

        @sample_group.run_benchmark

        format.html { redirect_to @sample_group, notice: 'Sample was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sample_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @sample_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def results
    sample_group = SampleGroup.find(params[:sample_group_id])
    @data = sample_group.samples_results
  end


  def run
    @sample_group.run_benchmark
    redirect_to sample_group_path(@sample_group)
  end

  private

  def set_sample_group
    @sample_group = SampleGroup.find(params[:id])
  end

  def sample_group_params
    params[:sample_group].permit(:title, :description,
                                 samples_attributes: [:title, :code])
  end

end