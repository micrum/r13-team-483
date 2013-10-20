class SampleGroupsController < ApplicationController

  before_action :set_sample_group, only: [:show, :edit, :run]


  def index
    @sample_groups = SampleGroup.order('updated_at DESC').first(6)
    @demo_group = SampleGroup.new(title: 'Benchmark demo')
    @demo_group.samples.build(title: 'Test sample', code: sample_code)
  end


  def show
  end


  def new
    b_params = params[:sample_group] ? sample_group_params : nil

    @sample_group = SampleGroup.new(b_params)
    @sample_group.samples.build(code: sample_code) if @sample_group.samples.empty?
  end


  def edit
  end


  def create
    @sample_group = SampleGroup.new(sample_group_params)

    respond_to do |format|
      if @sample_group.save

        @sample_group.run_benchmark

        format.html { redirect_to edit_sample_group_path(@sample_group), notice: 'Sample was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sample_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @sample_group.errors, status: :unprocessable_entity }
      end
    end
  end


  def run
    @sample_group.run_benchmark
    redirect_to sample_group_path(@sample_group)
  end

  def results
    sample_group = SampleGroup.find(params[:sample_group_id])
    @data = sample_group.samples_results
    render json: @data
  end

  private

  def sample_code
    <<CODE
# init (do not delete the comment)
arr = [0] * 1_000

# benchmark (do not delete the comment)
1000000.times do
  arr.size
end
CODE
  end

  def set_sample_group
    @sample_group = SampleGroup.find(params[:id])
  end

  def sample_group_params
    params[:sample_group].permit(:title, :description,
                                 samples_attributes: [:title, :code])
  end

end