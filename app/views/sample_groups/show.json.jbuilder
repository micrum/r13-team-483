json.extract! @sample_group, :id, :title, :description, :created_at, :updated_at

json.samples @sample_group.samples do |sample|
  #json.status_text status_text(sample.status)
  json.status_text 'timeout'
  json.extract! sample, :id, :status, :sys_time, :real_time, :user_time, :memory
  json.sys_time_text format_time(sample.sys_time)
  json.real_time_text format_time(sample.real_time)
  json.user_time_text format_time(sample.user_time)
  json.memory_text number_to_human_size(sample.memory)
end
