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

#second sample

sample_group_2 = SampleGroup.create(title: 'Benchmark in benchmark',
                                  description: 'timing ruby code')


Sample.create(
    title: '+= sample',
    code:
        (a = ""
        1000000.times { a += "." }),

    sample_group: sample_group_2
)
Sample.create(
    title: 'shovel sample',
    code:
        (a = ""
        1_000_000.times { a << "." }),

    sample_group: sample_group_2
)

sample_group_2.run_benchmark


#3rd sample

sample_group_3 =  SampleGroup.create(title: 'Benchmark in benchmark',
                                    description: 'timing ruby code')

Sample.create(
    title: 'sample timing',
    code:

        (beginning_time = Time.now
        (1..10000).each { |i| i }
        end_time = Time.now
        puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"),

    sample_group: sample_group_3
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

    sample_group: sample_group_3
)

sample_group_3.run_benchmark


#sample #4

sample_group_4 = SampleGroup.create(title: 'bang! methods',
                                   description: 'bang! methods is faster')

Sample.create(
    title: 'bang sample',
    code:
        (def merge!(array)
          array.inject({}) { |h, e| h.merge!(e => e) }
        end
        n = 10000
        array = (0..n).to_a
        merge!(array)),

    sample_group: sample_group_4
)
Sample.create(
    title: 'another sample',
    code:
        (def merge(array)
          array.inject({}) { |h, e| h.merge(e => e) }
        end
        n = 10000
        array = (0..n).to_a
        merge(array)),

    sample_group: sample_group_4
)

sample_group_4.run_benchmark


#sample #5

sample_group_5 = SampleGroup.create(title: 'condition vs exception',
                                    description: 'exceptions slow against conditional statements.')

Sample.create(
    title: 'condition',
    code:
        (class Obj
          def with_condition
            respond_to?(:some_method) ? self.some_method : nil
          end

        end

        obj = Obj.new
        N = 10_000_000),

    sample_group: sample_group_5
)
Sample.create(
    title: 'rescue',
    code:
        (class Obj

          def with_rescue
            self.some_method
          rescue NoMethodError
            nil
          end
        end

        obj = Obj.new
        N = 10_000_000),

    sample_group: sample_group_5
)

sample_group_5.run_benchmark


#sample #6

sample_group_6 = SampleGroup.create(title: 'interpolating vs concatenating ',
                                    description: 'interpolated strings and concatenated strings')

Sample.create(
    title: 'interpolating',
    code:
       (text="a"*10000000
        puts  "some text, #{text}"),

    sample_group: sample_group_6
)
Sample.create(
    title: 'cont',
    code:
        (text="a"*10000000
        puts  "some text, "<<text),

    sample_group: sample_group_6
)

sample_group_6.run_benchmark


#sample #7

sample_group_7 = SampleGroup.create(title: 'bang! sample ',
                                    description: 'once more bang! sample')

Sample.create(
    title: 'collect',
    code:
        (1..100000000).to_a.collect!,
    sample_group: sample_group_7
)
Sample.create(
    title: 'collect!',
    code:
        (1..100000000).to_a.collect,
    sample_group: sample_group_7
)

sample_group_7.run_benchmark

#sample #8

sample_group_8 = SampleGroup.create(title: '.concat array ',
                                    description: 'sample with concatenated arrays')

Sample.create(
    title: '+',
    code:
        (1..1000000).to_a+(1..10000).to_a,
    sample_group: sample_group_8
)
Sample.create(
    title: 'concat',
    code:
        (1..1000000).to_a.concat((1..10000).to_a),
    sample_group: sample_group_8
)

sample_group_8.run_benchmark


#sample #9

sample_group_9 = SampleGroup.create(title: 'compact method ',
                                    description: 'compact vs compact!')

Sample.create(
    title: '+',
    code:
        (1..10000).to_a.compact!,
    sample_group: sample_group_9
)
Sample.create(
    title: 'concat',
    code:
        (1..10000).to_a.compact,
    sample_group: sample_group_9
)

sample_group_9.run_benchmark

#sample #10

sample_group_10 = SampleGroup.create(title: 'strings',
                                    description: 'string with different lenth')

Sample.create(
    title: 'long string',
    code:
        puts 'x'+(1..100000000).to_a.to_s,
    sample_group: sample_group_10
)
Sample.create(
    title: 'short string',

    code:
        puts 'x'+(1..2).to_a.to_s,
    sample_group: sample_group_10
)

sample_group_10.run_benchmark