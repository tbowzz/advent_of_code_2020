require 'set'

text = File.open('day_06_input.txt').read
group_answers = Set.new
group_unanimous_answers = Set.new
yes_count = 0
unanimous_yes_count = 0
new_group = true
text.each_line do |raw|
  if raw == "\n"
    yes_count += group_answers.length
    group_answers.clear
    unanimous_yes_count += group_unanimous_answers.length
    group_unanimous_answers.clear
    new_group = true
    next
  end
  answers = raw.strip.split('')
  group_answers.merge(answers)

  if new_group
    group_unanimous_answers.merge(answers)
  else
    group_unanimous_answers.each do |previous_group_answer|
      group_unanimous_answers.delete(previous_group_answer) if !answers.include?(previous_group_answer)
    end
  end
  new_group = false
end

yes_count += group_answers.length
unanimous_yes_count += group_unanimous_answers.length

puts "Part 1: Yes count: #{yes_count}"
puts "Part 2: Unanimous yes count: #{unanimous_yes_count}"
