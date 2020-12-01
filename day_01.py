import time


def part_1(data):
  start = time.time()
  for first in data:
    for second in data:
      if first + second == 2020:
        elapsed = time.time() - start
        return [first, second], elapsed
  print("Nothing found!")
  exit(1)


def part_1_optimized(data):
  start = time.time()
  data = sorted(data)
  for ii in range(len(data)):
    for jj in range(ii, len(data)):
      if data[ii] + data[jj] == 2020:
        elapsed = time.time() - start
        return [data[ii], data[jj]], elapsed
  print("Nothing found!")
  exit(1)


def part_2(data):
  start = time.time()
  selected_pairs = list()
  for first in data:
    for second in data:
      for third in data:
        if first + second + third == 2020:
          elapsed = time.time() - start
          return [first, second, third], elapsed
  print("Nothing found!")
  exit(1)


def part_2_optimized(data):
  start = time.time()
  data = sorted(data)
  for ii in range(len(data)):
    for jj in range(ii, len(data)):
      for kk in range(jj, len(data)):
        if data[ii] + data[jj] + data[kk] == 2020:
          elapsed = time.time() - start
          return [data[ii], data[jj], data[kk]], elapsed
  print("Nothing found!")
  exit(1)


def run_many_times(func, data):
  average = 0
  for iteration in range(20):
    numbers, elapsed = func(data)
    average += elapsed
  average = average / 10
  return numbers, elapsed


def get_sum(numbers):
  sum = 0
  for each in numbers:
    sum += each
  return sum


def get_product(numbers):
  the_product = 1
  for each in numbers:
    the_product *= each
  return the_product


with open('day1_input.txt', 'r') as f:
  raw = f.readlines()
data = list()
for line in raw:
  data.append(int(line))

selected_numbers, elapsed = run_many_times(part_1, data)
print("Part 1: {:.4f} seconds".format(elapsed))
print("{}".format(selected_numbers))
print("sum: {}, product: {}".format(get_sum(selected_numbers), get_product(selected_numbers)))
print()

selected_numbers, elapsed = run_many_times(part_1_optimized, data)
print("Part 1 - Optimized: {:.4f} seconds".format(elapsed))
print("{}".format(selected_numbers))
print("sum: {}, product: {}".format(get_sum(selected_numbers), get_product(selected_numbers)))
print()

selected_numbers, elapsed = run_many_times(part_2, data)
print("Part 2: {:.4f} seconds".format(elapsed))
print("{}".format(selected_numbers))
print("sum: {}, product: {}".format(get_sum(selected_numbers), get_product(selected_numbers)))
print()

selected_numbers, elapsed = run_many_times(part_2_optimized, data)
print("Part 2 - Optimized: {:.4f} seconds".format(elapsed))
print("{}".format(selected_numbers))
print("sum: {}, product: {}".format(get_sum(selected_numbers), get_product(selected_numbers)))
print()
