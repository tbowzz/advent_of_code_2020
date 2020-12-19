
def get_preamble_sums(preamble)
  sums = []
  preamble.each do |outer|
    preamble.each do |inner|
      sums << outer + inner
    end
  end
  sums.uniq.sort
end

lines = []
File.open('day_09_input.txt').each { |line| lines << Integer(line.strip) }

preamble_length = 25
invalid_number = 0
(preamble_length..lines.length - 1).each do |encoding_index|
  number_to_check = lines[encoding_index]
  current_preamble = lines[encoding_index - preamble_length..encoding_index - 1]
  valid_numbers = get_preamble_sums(current_preamble)
  unless valid_numbers.include?(number_to_check)
    invalid_number = number_to_check
    break
  end
end
puts "Part 1 Violation: #{invalid_number}" # 776203571

complete = false
sum_values = []
(0..lines.length - 1).each do |ii|
  sum_values.clear
  sum_values << lines[ii]
  (ii + 1..lines.length - 1).each do |jj|
    sum_values << lines[jj]
    sum = sum_values.inject(:+)
    if sum >= invalid_number
      complete = true if sum == invalid_number
      break
    end
  end
  break if complete
end

encryption_weakness = sum_values.min + sum_values.max
puts "Part 2 encryption weakness: #{encryption_weakness}" # 104800569
