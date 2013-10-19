json.array!(@sample_groups) do |sample_group|
  json.extract! sample_group, :title, :description
  json.url sample_group_url(sample_group, format: :json)
end
