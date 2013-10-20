module HomeHelper

  def status_text(sample_status)
    SampleStatus.status_text(sample_status)
  end

end
