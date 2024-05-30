// control decoder
//module Control #(parameter opwidth = 3, mcodebits = 4)(
//  input [mcodebits-1:0] instr,    // 4-bit opcode, 1 bit identifier, 4 bit operand
//  output logic RegDst, Branch, 
//     MemtoReg, MemWrite, ALUSrc, RegWrite,
//  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

module Control (
	input [3:0]			opcode,			// main opcode
	input					identifier,		// specifies op/imm/lookup
	output logic		RegWrite,		// write to reg
	output logic		AccWrite,		// write to acc
	output logic		MemRead,			// read from mem
	output logic		MemWrite,		// write to mem
	output logic		start,			// start program
	output logic		halt,				// stop
	output logic		branch,			// branching
	output logic		Lookup			// lookup table needed
	
	);

always_comb begin
// defaults
//  RegDst 	=   'b0;   // 1: not in place  just leave 0
//  Branch 	=   'b0;   // 1: branch (jump)
//  MemWrite  =	'b0;   // 1: store to memory
//  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
//  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
//  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
//  ALUOp	    =   'b111; // y = a+0;
  
  // defaults: Do I need start bit to set these to default values?
  RegWrite	= 0;
  AccWrite	= 0;
  MemRead	= 0;
  MemWrite	= 0;
  start		= 0;
  halt		= 0;
  branch		= 0;
  Lookup		= 0;
  

case(opcode)    
  'b0000:  begin					
               MemWrite = 'b1;     
               RegWrite = 'b0;      
			 end
  'b0001:  begin					
               MemWrite = 'b1;     
               RegWrite = 'b0;      
			 end  
  'b00010:  begin				  
			   MemtoReg = 'b1;    
             end
// ...
endcase

end
	
endmodule