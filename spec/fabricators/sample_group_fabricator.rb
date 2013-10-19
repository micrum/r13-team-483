Fabricator(:sample_group) do
  samples(count: 3) { Fabricate(:sample) }
end