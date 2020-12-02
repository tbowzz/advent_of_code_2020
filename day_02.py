with open('day_02_input.txt', 'r') as f:
    raw = f.readlines()
data = list()
part_1_valid_count = part_2_valid_count = 0
for line in raw:
    info = line.split(':')
    limits = info[0].split('-')
    min = int(limits[0])
    max = int(limits[1].split(' ')[0])
    first_position = min - 1
    second_position = max - 1
    letter = limits[1].split(' ')[1]
    password = info[1].strip()
    letter_count = password.count(letter)
    if min <= letter_count <= max:
        part_1_valid_count += 1
    positions = [pos for pos, char in enumerate(password) if char == letter]
    if (first_position in positions and second_position not in positions) or \
       (first_position not in positions and second_position in positions):
        part_2_valid_count += 1

print("Part 1: Valid passwords: {}".format(part_1_valid_count))
print("Part 2: Valid passwords: {}".format(part_2_valid_count))
