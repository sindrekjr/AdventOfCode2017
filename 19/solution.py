lines = []; letters = ""
with open("input", "r") as f:
    for line in f:
        lines.append(line)
        letters += line.replace('|','').replace('-','').replace('+','').replace(' ','').strip()

directions = { 'n': (-1,0), 's': (1,0), 'w': (0,-1), 'e': (0,1) }
d = 's'

res = ""
steps = 0
y = 0; x = 0
while lines[y][x] == ' ': x += 1
while True:
    steps += 1
    while lines[y][x] != '+':
        if lines[y][x] in letters: res += lines[y][x]
        if len(res) == len(letters):
            print("Part 1: {}".format(res) + "\nPart 2: {}".format(steps))
            exit(0)
        y += directions[d][0]; x += directions[d][1]
        steps += 1

    if d in "ns":
        if lines[y + directions['w'][0]][x + directions['w'][1]] != ' ': d = 'w'
        else: d = 'e'
    else:
        if lines[y + directions['n'][0]][x + directions['n'][1]] != ' ': d = 'n'
        else: d = 's'

    y += directions[d][0]; x += directions[d][1]
