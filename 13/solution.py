walls = []
with open("input", "r") as f:
    walls = [list(map(int, x.strip().split(":"))) for x in f]

severity = 0
for w in walls:
    layer, depth = w
    if((layer % ((depth - 1)*2)) == 0): severity += layer*depth
print(severity)

finished = False
delay = 0
while not finished:
    finished = True
    delay += 1
    for w in walls:
        layer, depth = w
        if((layer + delay) % ((depth - 1)*2)) == 0: finished = False
print(delay)
