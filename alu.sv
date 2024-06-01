// combinational -- no clock
// sample -- change as desired
module alu(
  input[3:0] alu_cmd,    		// 4-bit opcode
  input identifier		 		// identifier bit for opcode
  input[7:0] inAcc, inReg,	 	// 8-bit wide data path
  input inOverflow		 		// overflow flag
  output logic[7:0] rslt,		// result
  output logic outOverflow 	// overflow out
);

always_comb begin 
  rslt = 'b0;                
  zero = !rslt;
  pari = ^rslt;
  case(alu_cmd)
		// load (lwr)
		4'b0000:
			rslt = inReg;
		// store (swr)
		4'b0001:
			rslt = inReg;
		// move to register (mov)
		4'b0010:
			rslt = inAcc;
		// move from register (mof)
		4'b0011:
			rslt = inReg;
		// and (and)
		4'b0100:
			rslt = (inAcc & inReg);
		// or (orr)
		4'b0101:
			rslt = (inAcc | inReg);
		// xor (xor)
		4'b0110:
			rslt = (inAcc ^ inReg);
		// add (add)
		4'b0111:
			// see psuedocode for alternative
//			{outOverflow, rslt} = inAcc + inReg + inOverflow;
			rslt = (inAcc + inReg);
		// subtract (sub)
		4'b1000:
			rslt = (inAcc - inReg);
		// left shift logical (lsl)
		4'b1001:
			rslt = (inAcc << inReg);
		// right shift logical (rsl)
		4'b1010:
			rslt = (inAcc >> inReg);
		// set 1 if acc < value (cmp)
		4'b1011:
			begin
				if(inAcc < inReg)
					rslt = 8'b0000_0001;
				else
					rslt = 8'b0000_0000;
			end
		// branch if acc == 0 (beq)
		4'b1100:
			begin
				if(inAcc == 0)
					rslt = inReg;
				else
					rslt = 8'b0000_0000; // 0 in LUT would be default (pc + 1)
			end
		// branch if acc != 0 (bne
		4'b1101:
			begin
				if(inAcc != 0)
					rslt = inReg;
				else
					rslt = 8'b0000_0000; // 0 in LUT would be default (pc + 1)
			end
		
		//2 extra instructions
		4'b1110:;
		4'b1111:;
		default:
			begin
				rslt = 8'b0000_0000;
				outOverflow = inOverflow;
		
  endcase
end
   
endmodule