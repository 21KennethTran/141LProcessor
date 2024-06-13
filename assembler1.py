opcode = {"lwr":"0000", "str":"0001", "mov":"0010", "mof":"0011", "and":"0100", "or":"0101", "xor":"0110", "add":"0111",
          "sub":"1000", "lsl":"1001", "rsl":"1010", "cmp":"1011", "beq":"1100", "bne":"1101", "j":"1110", "don":"1111"}

operand = {"$t0":"0000", "$t1":"0001", "$t2":"0010", "$t3":"0011", "$t4":"0100", "$t5":"0101", "$t6":"0110", "$t7":"0111",
          "$t8":"1000", "$t9":"1001", "$t10":"1010", "$t11":"1011", "$t12":"1100", "$t13":"1101", "$t14":"1110", "$t15":"1111"}

Lookup = {"$t0":"0000", "$t1":"0001", "$t2":"0010", "$t3":"0011", "$t4":"0100", "$t5":"0101", "$t6":"0110", "$t7":"0111",
          "$t8":"1000", "$t9":"1001", "$t10":"1010", "$t11":"1011", "$t12":"1100", "$t13":"1101", "$t14":"1110", "$t15":"1111"}
def assembleLine(part):
    final = ""

    opc = part[0].lower()

    if opc.endswith('*'):
        opc = opc.strip('*')
        if opc not in opcode:
            return None
        final += opcode[opc] + "1"
    else:
        if opc not in opcode:
            return None
        final += opcode[opc] + "0"

    ope = part[1]
    if ope in operand:
        final += operand[ope]
    else:
        final += ope # deal with jump mapping later
    
    return final

with open("code2.txt", "r") as file:
    lines = file.readlines()
    full = []
    for line in lines:
        line = line.split('#')[0].strip()
        if line:
            part = line.split()
            instr = assembleLine(part)
            if instr is not None:
                full.append(instr)

with open("machcode2.txt", "w") as out:
        for instruction in full:
            out.write(instruction + '\n')
