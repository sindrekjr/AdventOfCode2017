jumps = []
with open("input", 'r') as f:
    for l in f: jumps.append(int(l))

def calc(p, j):
    j = list(j)

    count = 0
    current = 0
    position = 0
    while position >= 0 and position < len(j):
        count += 1
        current = position
        position += j[current]
        if p == 2 and position >= current + 3: j[current] -= 1
        else: j[current] += 1

    return count

print("Part 1: {} \nPart 2: {}".format(calc(1, jumps), calc(2, jumps)))
