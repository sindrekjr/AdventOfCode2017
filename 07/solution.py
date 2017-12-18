import random

progs = {}
subs = {}
with open("input", "r") as f:
    for line in f:
        line = line.replace(",","").strip().split(" ")

        sublist = []
        for i in range(3, len(line)): sublist.append(line[i])
        progs[line[0]] = int(line[1].replace("(","").replace(")",""))
        subs[line[0]] = sublist

cur = [ x for x in progs if x not in [ y for z in subs for y in subs[z] ] ][0]
print("Part 1: {}".format(cur))

def subWeights(r):
    total = 0
    for s in subs[r]: total += progs[s] + subWeights(s)
    return total

found = False
while not found:
    curSubs = {s: progs[s] + subWeights(s) for s in subs[cur]}
    if len(curSubs) and len(set([ curSubs[x] for x in curSubs ])) != 1:
        cur = [ x for x in curSubs if curSubs[x] not in [ curSubs[y] for y in curSubs if y != x ] ][0]
        offset = curSubs[cur] - curSubs[random.choice([ x for x in curSubs if x != cur ])]
    else:
        print("Part 2: {}".format(progs[cur] - offset))
        found = True
