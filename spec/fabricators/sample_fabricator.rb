Fabricator(:sample) do
  title 'title'

  code <<CODE
# init (do not delete the comment)
arr = [0] * 1_000

# benchmark (do not delete the comment)
1000000.times do
  arr.size
end

CODE

end

Fabricator(:bad_sample, from: :sample) do
  code 'some invalid code'
end

Fabricator(:timeout_sample, from: :sample) do
  code <<CODE
# benchmark

x = 1
1000000000.times do
  x += 1
end

CODE

end

Fabricator(:unsafe_sample_1, from: :sample) do
  code <<CODE
# benchmark
`rm *`
CODE

end

Fabricator(:unsafe_sample_2, from: :sample) do
  code <<CODE
# benchmark
system('rm *')
CODE

end

Fabricator(:unsafe_sample_3, from: :sample) do
  code <<CODE
# benchmark
File.read('/etc/passwd')
CODE

end


