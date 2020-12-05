text = File.open('day_05_input.txt').read
seats = []
text.each_line do |raw|
  seats.push(raw.strip)
end

max_id = 0
seat_ids = []
seats.each do |seat|
  rows = (0..127).to_a
  cols = (0..7).to_a
  seat.split('').each do |position|
    split_point = (rows.length / 2)
    if position == 'F'
      rows = rows[0..split_point - 1]
      next
    elsif position == 'B'
      rows = rows[split_point..rows.length]
      next
    end
    split_point = (cols.length / 2)
    if position == 'L'
      cols = cols[0..split_point - 1]
    elsif position == 'R'
      cols = cols[split_point..cols.length]
    end
  end
  seat_id = rows[0] * 8 + cols[0]
  max_id = seat_id if seat_id > max_id
  seat_ids.push(seat_id)
end

puts "Part 1: Highest seat id: #{max_id}"

seat_ids.sort!
previous_seat = seat_ids[0] - 1
seat_ids.each do |seat|
  if seat != previous_seat + 1
    puts "Part 2: Your seat: #{seat - 1}" if seat != previous_seat + 1
    break
  end
  previous_seat = seat
end
