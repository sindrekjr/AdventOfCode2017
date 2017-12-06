jumps = [];
with open("input", 'r') as f:
    for l in f: jumps.append(int(l))

count = 0
current = 0
position = 0
while position >= 0 and position < len(jumps):
    count += 1
    current = position
    position += jumps[current]
    if position >= current + 3: jumps[current] -= 1
    else: jumps[current] += 1

print(count)
