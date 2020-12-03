def traverse(col_movement, row_movement, forest)
  row_index = col_index = tree_count = 0
  while row_index < forest.length - 1
    row_index += row_movement
    row = forest[row_index]
    col_index = (col_index + col_movement) % row.length
    tree_count += 1 if row[col_index] == '#'
  end
  tree_count
end

text = File.open('day_03_input.txt').read
rows = []
text.each_line do |row|
  cols = []
  row.strip.each_char do |col|
    cols.push(col)
  end
  rows.push(cols)
end

part_1 = traverse(3, 1, rows)
puts "Part 1: #{part_1}"
puts "Part 2: #{traverse(1, 1, rows) *
    traverse(3, 1, rows) *
    traverse(5, 1, rows) *
    traverse(7, 1, rows) *
    traverse(1, 2, rows)}"
