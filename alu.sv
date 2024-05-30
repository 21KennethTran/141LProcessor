// combinational -- no clock
// sample -- change as desired
module alu(
  input[3:0] alu_cmd,    // 4-bit opcode
  input identifier		 // identifier bit for opcode
  input[7:0] inAcc, inReg,	 // 8-bit wide data path
  input      sc_i,       // shift_carry in
  input inOverflow		 // overflow flag
  output logic[7:0] rslt,
  output logic outOverflow // overflow out
);

always_comb begin 
  rslt = 'b0;            
  sc_o = 'b0;    
  zero = !rslt;
  pari = ^rslt;
  case(alu_cmd)
    3'b000: // add 2 8-bit unsigned; automatically makes carry-out
      {sc_o,rslt} = inA + inB + sc_i;
	3'b001: // left_shift
	  {sc_o,rslt} = {inA, sc_i};
      /*begin
		rslt[7:1] = ina[6:0];
		rslt[0]   = sc_i;
		sc_o      = ina[7];
      end*/
    3'b010: // right shift (alternative syntax -- works like left shift
	  {rslt,sc_o} = {sc_i,inA};
    3'b011: // bitwise XOR
	  rslt = inA ^ inB;
	3'b100: // bitwise AND (mask)
	  rslt = inA & inB;
	3'b101: // left rotate
	  rslt = {inA[6:0],inA[7]};
	3'b110: // subtract
	  {sc_o,rslt} = inA - inB + sc_i;
	3'b111: // pass A
	  rslt = inA;
  endcase
end
   
endmodule