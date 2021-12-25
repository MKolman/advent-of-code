def get_floor():
    floor = []
    right = []
    down = []
    for row, line in enumerate(open(0)):
        floor.append([])
        for col, x in enumerate(line.strip()):
            if x == '.':
                floor[-1].append(None)
            elif x == '>':
                floor[-1].append(1)
                right.append([row, col])
            elif x == 'v':
                floor[-1].append(-1)
                down.append([row, col])
    return floor, right, down

def move_right(floor, right):
    w = len(floor[0])
    col0 = [r[0] for r in floor]
    result = 0
    for i, (r, c) in enumerate(right):
        nc = (c+1) % w
        if (nc == 0 and col0[r] is None) or (nc != 0 and floor[r][nc] is None):
            floor[r][c], floor[r][nc] = floor[r][nc], floor[r][c]
            right[i][1] = nc
            result += 1
    return result

def move_down(floor, down):
    h = len(floor)
    row0 = floor[0][:]
    result = 0
    for i, (r, c) in enumerate(down):
        nr = (r + 1) % h
        if (nr == 0 and row0[c] is None) or (nr != 0 and floor[nr][c] is None):
            floor[r][c], floor[nr][c] = floor[nr][c], floor[r][c]
            down[i][0] = nr
            result += 1
    return result

def main():
    floor, right, down = get_floor()
    steps = 0
    while True:
        moved = move_right(floor, right)
        moved += move_down(floor, down)
        steps += 1
        if moved == 0:
            break
        right.sort()
        down.sort()
    print(steps)

main()
