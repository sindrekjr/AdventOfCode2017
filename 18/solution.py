lines = []
registers = {}
with open("input", "r") as f:
    for l in f: lines.append(l.strip().split(" "))
    for l in lines: registers[l[1]] = 0
    registers.pop('1', None)

pos = 0
sound = 0
while pos >= 0 and not pos >= len(lines):
    l = lines[pos]
    pos += 1

    if x not in registers: x = int(l[1])
    else: x = l[1]
    if len(l) > 2:
        if l[2] in registers: y = registers[l[2]]
        else: y = int(l[2])

    if l[0] == "snd": sound = registers[x]
    elif l[0] == "set": registers[x] = y
    elif l[0] == "add": registers[x] += y
    elif l[0] == "mul": registers[x] *= y
    elif l[0] == "mod": registers[x] %= y
    elif l[0] == "rcv":
        if x != 0:
            print(sound)
            break
    elif l[0] == "jgz":
        if x in registers: x = registers[x]
        if x > 0: pos += y - 1
