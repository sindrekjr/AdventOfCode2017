with open("input", "r") as f:
    lines = [l.strip().split(" ") for l in f]
    regs = {r[1]: 0 for r in lines if r[1] != '1'}
    count = 0
    i = 0
    while i >= 0 and not i >= len(lines):
        if lines[i][1] in regs: x = lines[i][1]
        else: x = int(lines[i][1])
        if lines[i][2] in regs: y = regs[lines[i][2]]
        else: y = int(lines[i][2])
        if lines[i][0] == "set": regs[x] = y
        elif lines[i][0] == "sub": regs[x] -= y
        elif lines[i][0] == "mul":
            regs[x] *= y
            count += 1
        elif lines[i][0] == "jnz":
            if x in regs: x = regs[x]
            if x != 0: i += y - 1
        i += 1
print(count)
