require 'set'

class BagInfo
  attr_accessor :name, :count

  def initialize(name, count)
    @name = name
    @count = Integer(count)
  end
end

text = File.open('day_07_input.txt').read
child_bags = Hash.new
parent_bags = Hash.new
content = []
text.each_line do |raw|
  item = raw.strip
  parent_name = item.split('bags')[0].strip
  children = item.split('contain')[1]
  if children.include?(',')
    children = children.split(',')
    children.each do |child|
      info = child.strip.split('bag')[0].split(' ', 2)
      content.push(BagInfo.new(info[1].strip, info[0].strip))
    end
  else
    info = children.strip.split('bag')[0].split(' ', 2)
    content.push(BagInfo.new(info[1].strip, info[0].strip)) unless info[1].strip == "other"
  end

  content.each do |c|
    # For part 1
    child_bags[c.name] = [] unless child_bags.key?(c.name)
    child_bags[c.name].push(parent_name)
    # For part 2
    parent_bags[parent_name] = [] unless parent_bags.key?(parent_name)
    parent_bags[parent_name].push(c)
  end
  content.clear
end

# For part 1
desired_bag = "shiny gold"
containers_of_desired_bag = Set.new
child_bags[desired_bag].each do |parent_bag|
  child_bags[parent_bag] = child_bags[parent_bag].to_a if child_bags[parent_bag].nil?
  child_bags[desired_bag].concat(child_bags[parent_bag])
  containers_of_desired_bag.add(parent_bag)
end
puts "Part 1: Bags that contain #{desired_bag}: #{containers_of_desired_bag.count}"

# For part 2
bags_of_desired_bag = 0
parent_bags[desired_bag].each do |child_bag|
  bags_of_desired_bag += child_bag.count
  parent_bags[desired_bag].concat(parent_bags[child_bag.name].map { |nested| BagInfo.new(nested.name, nested.count * child_bag.count) }) if parent_bags.key?(child_bag.name)
end
puts "Part 2: #{desired_bag} contains #{bags_of_desired_bag} bags"
