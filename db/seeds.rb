# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

def generate_code(number)
  <<CODE
# init (do not delete the comment)
arr = [0] * 1_000

# benchmark (do not delete the comment)
#{number}.times do
  arr.size
end
CODE
end


sample_group = SampleGroup.create(title: 'Simple loop test',
                                  description: 'This benchmark tests loops with different number of iterations')

Sample.create(
    title: 'Initial code sample. Let it be the slowest one with 1000000 iterations',
    code:
        generate_code(1000000),
    sample_group: sample_group
)
Sample.create(
    title: 'The same code, but 100000 iterations',
    code: generate_code(100000),
    sample_group: sample_group
)
Sample.create(
    title: 'The same code, but 10000 iterations',
    code: generate_code(10000),
    sample_group: sample_group
)
Sample.create(
    title: 'The fastest sample - only 1000 iterations',
    code: generate_code(1000),
    sample_group: sample_group
)

sample_group.run_benchmark

#second sample

sample_group_2 = SampleGroup.create(title: '+= vs shovel',
                                    description: 'timing ruby code')


Sample.create(
    title: '+= sample',
    code:
    (<<CODE
# init (do not delete the comment)
a = ""

# benchmark (do not delete the comment)
10000.times { a += "." }
CODE
    ),

    sample_group: sample_group_2
)
Sample.create(
    title: 'shovel sample',
    code:
        (<<CODE
# init (do not delete the comment)
a = ""

# benchmark (do not delete the comment)
10000.times { a << "." }
CODE
        ),

    sample_group: sample_group_2
)

sample_group_2.run_benchmark


#sample #6

sample_group_6 = SampleGroup.create(title: 'interpolating vs concatenating ',
                                    description: 'interpolated strings and concatenated strings')

Sample.create(
    title: 'interpolating',
    code:
        (<<CODE
# init (do not delete the comment)
text = "a" * 10000000

# benchmark (do not delete the comment)
puts  "some text, \#{text}"
CODE
        ),

    sample_group: sample_group_6
)
Sample.create(
    title: 'cont',
    code:
        (<<CODE
# init (do not delete the comment)
text = "a" * 10000000

# benchmark (do not delete the comment)
puts 'some text' << text
CODE
        ),

    sample_group: sample_group_6
)

sample_group_6.run_benchmark




#sample #4

sample_group_4 = SampleGroup.create(title: 'bang! methods',
                                    description: 'bang! methods is faster')

Sample.create(
    title: 'bang sample',
    code:
        (<<CODE
# init (do not delete the comment)
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

# benchmark (do not delete the comment)
10000.times do
h1.merge(h2)
end
CODE
        ),


    sample_group: sample_group_4
)
Sample.create(
    title: 'another sample',
    code:
        (<<CODE
# init (do not delete the comment)
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

# benchmark (do not delete the comment)
10000.times do
h1.merge!(h2)
end
CODE
        ),

    sample_group: sample_group_4
)

sample_group_4.run_benchmark

#sample #7

sample_group_7 = SampleGroup.create(title: 'bang! sample ',
                                    description: 'once more bang! sample')

Sample.create(
    title: 'collect',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a.collect!
CODE
        ),
    sample_group: sample_group_7
)
Sample.create(
    title: 'collect!',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a.collect
CODE
        ),
    sample_group: sample_group_7
)

sample_group_7.run_benchmark



#sample #9

sample_group_9 = SampleGroup.create(title: 'compact method ',
                                    description: 'compact vs compact!')

Sample.create(
    title: '+',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a.compact!
CODE
        ),
    sample_group: sample_group_9
)
Sample.create(
    title: 'concat',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a.compact
CODE
        ),
    sample_group: sample_group_9
)

sample_group_9.run_benchmark



#sample #10

sample_group_10 = SampleGroup.create(title: 'strings',
                                     description: 'string with different length')

Sample.create(
    title: 'long string',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
puts "x"+(1..10000).to_a.to_s
CODE
        ),
    sample_group: sample_group_10
)
Sample.create(
    title: 'short string',

    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
puts "x"+(1..2).to_a.to_s
CODE
        ),
    sample_group: sample_group_10
)

sample_group_10.run_benchmark




#sample #8

sample_group_8 = SampleGroup.create(title: '.concat array ',
                                    description: 'sample with concatenated arrays')

Sample.create(
    title: '+',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a + (1..1000000).to_a
CODE
        ),
    sample_group: sample_group_8
)
Sample.create(
    title: 'concat',
    code:
        (<<CODE
# init (do not delete the comment)

# benchmark (do not delete the comment)
(1..100000).to_a.concat((1..1000000).to_a)
CODE
        ),
    sample_group: sample_group_8
)

sample_group_8.run_benchmark






