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
    jumps[current] += 1

print(count)
