operand = {"lwr*":"0000","swr":"0001","mov":"0010","mof*":"0011","and*":"0100","or":"0101","xor*":"0110","add*":"0111","sub*":"1000","lsl*":"1001","rsl*":"1010", "cmp*":"1011", "beq":"1100", "bne":"1101", "j":"1110", "done":"1111"}

with open("code1.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        final = ""
        # Separate into Instruction, Register, Immediate Value
        parts = line.split(" ")
        final += operand[parts[0]]
        match parts[0]:
            case "lwr*":
                #extract register number
                register = int(parts[1][2:])
                #convert to binary
                register = bin(register)[2:]
                #add to machine code
                final += str(register) + "0"
            case "str":
                #we'll go to r0
                if parts[1] == "$max":
                    final += "00000"
                #we'll go to r1
                else:
                    final += "00001"
            case "mov":
                #extract register number
                register = int(parts[1][2:])
                #convert to binary
                register = bin(register)[2:]
                #add to machine code
                final += str(register) + "0"
            case "mof":
                #extract register number
                register = int(parts[1][2:])
                #convert to binary
                register = bin(register)[2:]
                #add to machine code
                final += str(register) + "0"
            #this is the case of an integer
            case "mof*":
                #extract value
                value = int(parts[1])
                #convert to binary
                value = int 
            case "and":
                #extract register number
                register = int(parts[1][2:])
                #convert to binary
                register = bin(register)[2:]
                #add to machine code
                final += str(register) + "0"
            case "or":
                #extract register number
                register = int(parts[1][2:])
                #convert to binary
                register = bin(register)[2:]
                #add to machine code
                final += str(register) + "0"
        mach_code = open("mach_code.txt", "w")
        mach_code.write(final)
        file.close()

