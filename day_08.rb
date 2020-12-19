require 'set'

def run_code(boot_code, change_index)
  max_length = boot_code.length
  accumulator = 0
  executed_indices = Set.new
  index = 0
  boot_code[change_index][:instruction] = boot_code[change_index][:instruction].sub('jmp', 'nop') unless change_index == -1
  run = true
  while run
    if executed_indices.include?(index)
      boot_code[change_index][:instruction] = boot_code[change_index][:instruction].sub('nop', 'jmp') unless change_index == -1
      return true, accumulator
    end
    return false, accumulator if index == max_length
    instruction_set = boot_code[index]
    executed_indices.add(index)
    if instruction_set[:instruction] == "nop"
      index += 1
    elsif instruction_set[:instruction] == "acc"
      if instruction_set[:operator] == "+"
        accumulator += instruction_set[:count]
      else
        accumulator -= instruction_set[:count]
      end
      index += 1
    elsif instruction_set[:instruction] == "jmp"
      if instruction_set[:operator] == "+"
        index += instruction_set[:count] % max_length
      else
        tmp = index - instruction_set[:count]
        if tmp < 0
          index = max_length + tmp
        else
          index = tmp
        end
      end
    else
      puts "BAD INSTRUCTION: #{instruction_set[:instruction]}"
    end
  end
end

text = File.open('day_08_input.txt').read
boot_code = []
text.each_line do |raw|
  instruction_set = Hash.new
  instruction = raw.strip.split(' ')
  instruction_set[:instruction] = instruction[0]
  instruction_set[:operator] = instruction[1].split('').first
  instruction_set[:count] = Integer(instruction[1].split('')[1..].join)
  boot_code.push(instruction_set)
end

do_search, accumulator = run_code(boot_code, -1)
puts "Part 1: Accumulator: #{accumulator}"

accumulator = 0
swapped_inst_indices = boot_code.each_index.select { |i| boot_code[i][:instruction] == 'jmp' }
swapped_inst_indices.concat boot_code.each_index.select { |i| boot_code[i][:instruction] == 'nop' }
swapped_inst_indices.each do |change_index|
  do_search, accumulator = run_code(boot_code, change_index)
  break unless do_search
end

puts "Part 2: Accumulator: #{accumulator}"
