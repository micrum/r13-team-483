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
    code: generate_code(1000000),
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

sample_group_2 = SampleGroup.create(title: 'Benchmark in benchmark',
                                  description: 'timing ruby code')

#second sample

Sample.create(
    title: 'sample timing',
    code:
        (beginning_time = Time.now
        (1..10000).each { |i| i }
        end_time = Time.now
        puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"),

    sample_group: sample_group_2
)
Sample.create(
    title: 'sample with methods',
    code:
        (def time_method(method, *args)
          beginning_time = Time.now
          self.send(method, args)
          end_time = Time.now
          puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
        end
        def method_to_time(*args)
          (1..10000).each { |i| i }
        end

        time_method(:method_to_time)),

    sample_group: sample_group_2
)

sample_group_2.run_benchmark



