operand = {"lwr*":"0000","swr":"0001","mov":"0010","mof*":"0011","and*":"0100","orr*":"0101","xor*":"0110","add*":"0111","sub*":"1000","lsl*":"1001","rsl*":"1010", "cmp*":"1011", "beq":"1100", "bne":"1101", "j":"1110", "done":"1111"}

with open("code3.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        final = ""
        parts = line.split(" ")
        final += operand[parts[0]]
        if parts[0] == 'j':
            #write code to jump to a specific point
        elif parts[0] == 'bne':
            #write code to jump to a specific point
        elif parts[0] == 'beq':
            #write code to jump to a specific point
        elif parts[0] == 'bgt':
            #write code to jump to a specific point
        elif parts[0] == 'ble':
            #write code to jump to a specific point
        else:
            #get register
            register = int(parts[1][2:])
            register = bin(register)[2:]
            final += str(register)
            # get immediate value from lookup table
            if parts[0] == 'add' or parts[0] == 'sub':
                #add index of thing in lookup table
        mach_code = open("mach_code.txt", "w")
        mach_code.write(final)
        file.close()

