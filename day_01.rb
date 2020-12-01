def part_1(data)
  data.sort!
  (0..data.length - 1).each do |ii|
    (ii..data.length - 1).each do |jj|
      if data[ii] + data[jj] == 2020
        return [data[ii], data[jj]]
      end
    end
  end
end

def part_2(data)
  data.sort!
  (0..data.length - 1).each do |ii|
    (ii..data.length - 1).each do |jj|
      (jj..data.length - 1).each do |kk|
        if data[ii] + data[jj] + data[kk] == 2020
          return [data[ii], data[jj], data[kk]]
        end
      end
    end
  end
end

def select_numbers(desired_sum, incremental_values, search_start_index, data, current_depth, desired_depth)
  (search_start_index..data.length - 1).each do |index|
    if current_depth == desired_depth
      if sum(incremental_values) + data[index] == desired_sum
        incremental_values.push(data[index])
        return incremental_values
      end
    else
      tmp_values = incremental_values.dup
      tmp_values.push(data[index])
      possible_values = select_numbers(desired_sum, tmp_values, index + 1, data, current_depth + 1, desired_depth)
      return possible_values if sum(possible_values) == desired_sum
    end
  end
end

def select_for_sum(data, desired_sum, desired_depth)
  data.sort!
  time_sum = 0
  numbers = []
  100.times do
    start = Time.now
    numbers = select_numbers(desired_sum, [], 0, data, 1, desired_depth)
    time_sum += Time.now - start
  end
  elapsed = time_sum / 100.0
  return numbers, elapsed
end

def run_many_times(fun, data)
  sum = 0
  numbers = []
  100.times do
    start = Time.now
    numbers = fun.call(data)
    sum += Time.now - start
  end
  elapsed = sum / 100.0
  return numbers, elapsed
end

def sum(numbers)
  total = 0
  numbers.each { |n| total += n }
  total
end

def product(numbers)
  product = 1
  numbers.each { |n| product *= n }
  product
end

text=File.open('day_01_input.txt').read
data = text.each_line.map { |line| Integer(line) }

selected_numbers, elapsed = run_many_times(method(:part_1), data)
puts "Part 1: #{elapsed.round(4)} seconds"
puts "#{selected_numbers}"
puts "sum: #{sum(selected_numbers)}, product: #{product(selected_numbers)}"
puts

selected_numbers, elapsed = run_many_times(method(:part_2), data)
puts "Part 2: #{elapsed.round(4)} seconds"
puts "#{selected_numbers}"
puts "sum: #{sum(selected_numbers)}, product: #{product(selected_numbers)}"
puts

selected_numbers, elapsed = select_for_sum(data, 2020, 2)
puts "Part 1 recursive: #{elapsed.round(4)} seconds"
puts "#{selected_numbers}"
puts "sum: #{sum(selected_numbers)}, product: #{product(selected_numbers)}"
puts

selected_numbers, elapsed = select_for_sum(data, 2020, 3)
puts "Part 2 recursive: #{elapsed.round(4)} seconds"
puts "#{selected_numbers}"
puts "sum: #{sum(selected_numbers)}, product: #{product(selected_numbers)}"
puts
