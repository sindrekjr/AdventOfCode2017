with open("input", "r") as f:
    severity = 0
    for line in f:
        layer, depth = list(map(int, line.strip().split(":")))
        if((layer % ((depth - 1)*2)) == 0): severity += layer*depth

print(severity)
