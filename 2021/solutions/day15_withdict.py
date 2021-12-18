import sys
sys.setrecursionlimit(100000)

map=[]
shortest_ways=[]
with open('input/day15.txt', 'r') as f:
    for y,line in enumerate(f):
        map.append([int(r) for r in line.strip()])
        shortest_ways.append([float('inf') for _ in map[-1]])


cnt = 0
def search(x,y):
    global shortest_ways
    global cnt
    cnt += 1
    if cnt % 500000 == 0:
        print(cnt, x, y, shortest_ways[len_y-1][len_x-1])

    for new_x,new_y in [(x+1, y), (x, y+1), (x, y-1), (x-1, y)]:
        if not (0 <= new_x <= len_x-1 and 0 <= new_y <= len_y-1):
            continue
        new_risk=shortest_ways[y][x] + map[new_y][new_x]
        if new_risk < shortest_ways[new_y][new_x]:
            shortest_ways[new_y][new_x]=new_risk 
            search(new_x, new_y)

    return

shortest_ways[0][0]=0
len_y=len(map)
len_x=len(map[0])

search(0,0)
print(shortest_ways[len_y-1][len_x-1])
#print(shortest_ways)
