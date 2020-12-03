def traverse(col_movement, row_movement, forest):
    row_index = 0
    col_index = 0
    tree_count = 0
    while row_index < len(forest) - 1:
        row_index += row_movement
        row = forest[row_index]
        col_index = (col_index + col_movement) % len(row)
        col_char = row[col_index]
        if col_char == '#':
            tree_count += 1
    return tree_count


def run():
    with open('day_03_input.txt', 'r') as f:
        raw = f.readlines()

    rows = []
    for line in raw:
        cols = []
        for c in line.strip():
            cols.append(c)
        rows.append(cols)

    tree_count_1_1 = traverse(1, 1, rows)
    tree_count_3_1 = traverse(3, 1, rows)  # Part 1 solution
    tree_count_5_1 = traverse(5, 1, rows)
    tree_count_7_1 = traverse(7, 1, rows)
    tree_count_1_2 = traverse(1, 2, rows)

    part_2_solution = tree_count_1_1 * tree_count_3_1 * tree_count_5_1 * tree_count_7_1 * tree_count_1_2

    print("Part 1: Tree count = {}".format(tree_count_3_1))
    print("Part 2: Solution = {}".format(part_2_solution))


if __name__ == '__main__':
    run()
