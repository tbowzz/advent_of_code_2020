def is_valid_fieldset(field, value):
    if field in ['byr', 'iyr', 'eyr']:
        length = len(value) == 4
        if field == 'byr':
            limits = [1920, 2002]
        elif field == 'iyr':
            limits = [2010, 2020]
        elif field == 'eyr':
            limits = [2020, 2030]
        valid_year = limits[0] <= int(value) <= limits[1]
        return length and valid_year
    elif field == 'hgt':
        unit = value[-2:]
        if unit == 'cm':
            limits = [150, 193]
        elif unit == 'in':
            limits = [59, 76]
        else:
            return False
        num = value[:-2]
        return num.isnumeric() and limits[0] <= float(num) <= limits[1]
    elif field == 'hcl':
        return len(value) == 7 and value[0] == '#' and value[1:].isalnum()
    elif field == 'ecl':
        return value in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
    elif field == 'pid':
        return value.isnumeric() and len(value) == 9
    else:
        return True


def has_required_fields(current_fields):
    required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    return not len([i for i in required_fields if i not in current_fields])


def run():
    with open('day_04_input.txt', 'r') as f:
        raw = f.readlines()

    valid_passports_part_1 = 0
    valid_passports_part_2 = 0
    current_fields_part_1 = []
    current_fields_part_2 = []
    for line in raw:
        if line == '\n':
            current_fields_part_1.clear()
            current_fields_part_2.clear()
            continue
        data = line.strip().split(' ')
        for each in data:
            field, value = each.split(':')
            if is_valid_fieldset(field, value):
                current_fields_part_2.append(field)
            current_fields_part_1.append(field)
        if has_required_fields(current_fields_part_2):
            valid_passports_part_2 += 1
            current_fields_part_2.clear()
        if has_required_fields(current_fields_part_1):
            valid_passports_part_1 += 1
            current_fields_part_1.clear()

    print("Part 1: Valid passports = {}".format(valid_passports_part_1))  # 220
    print("Part 2: Valid passports = {}".format(valid_passports_part_2))  # 140


if __name__ == '__main__':
    run()
