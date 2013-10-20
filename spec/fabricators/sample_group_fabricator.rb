Fabricator(:sample_group) do
  title 'title'
  samples(count: 3) { Fabricate(:sample) }
end