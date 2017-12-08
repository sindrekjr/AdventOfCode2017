progs = [];
subs = [];
with open("input", "r") as f:
    for line in f:
        line = line.replace(",","").strip().split(" ")
        progs.append(line[0])
        for i in range(3, len(line)): subs.append(line[i])

print([x for x in progs if x not in subs])
