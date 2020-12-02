class PasswordDefinition
  attr_accessor :password, :min, :max, :pos_a, :pos_b, :letter

  def initialize(raw_definition)
    rules, password = raw_definition.split(':')
    rules = rules.split(/[\s,-]/)
    @password = password.strip
    @min = Integer(rules[0])
    @max = Integer(rules[1])
    @pos_a = @min - 1
    @pos_b = @max - 1
    @letter = rules[2]
  end

  def part_1_valid?
    count = @password.count(@letter)
    @min <= count && count <= @max
  end

  def part_2_valid?
    positions = (0...@password.length).find_all { |i| @password[i, 1] == @letter }
    (!positions.include?(@pos_a) && positions.include?(@pos_b)) || (positions.include?(@pos_a) && !positions.include?(@pos_b))
  end
end

text = File.open('day_02_input.txt').read
part_1_count = part_2_count = 0
text.each_line do |line|
  definition = PasswordDefinition.new(line)
  part_1_count += 1 if definition.part_1_valid?
  part_2_count += 1 if definition.part_2_valid?
end
puts "Part 1: #{part_1_count}"
puts "Part 2: #{part_2_count}"
