// control decoder
//module Control #(parameter opwidth = 3, mcodebits = 4)(
//  input [mcodebits-1:0] instr,    // 4-bit opcode, 1 bit identifier, 4 bit operand
//  output logic RegDst, Branch, 
//     MemtoReg, MemWrite, ALUSrc, RegWrite,
//  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

module Control (
	input [3:0]			opcode,			// main opcode
	input					identifier,		// specifies reg/imm
	output logic		RegWrite,		// write to reg
	output logic		AccWrite,		// write to acc
	output logic		MemRead,			// read from mem
	output logic		MemWrite,		// write to mem
	output logic		Start,			// Start program
	output logic		Done,				// stop
	output logic		Branch,			// Branching
	output logic		Lookup,			// lookup table needed; Branch and lookup are the same... need another bit for this?
	output logic		ImmVal			// use immediate value
	
	);

always_comb begin
// defaults
//  RegDst 	=   'b0;   // 1: not in place  just leave 0
//  Branch 	=   'b0;   // 1: Branch (jump)
//  MemWrite  =	'b0;   // 1: store to memory
//  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
//  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
//  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
//  ALUOp	    =   'b111; // y = a+0;
  
  // defaults: Do I need Start bit to set these to default values?
  RegWrite	= 0;
  AccWrite	= 0;
  MemRead	= 0;
  MemWrite	= 0;
  Start		= 0;				// probably do not need
  Done		= 0;
  Branch		= 0;
  Lookup		= 0;
  ImmVal		= 0;
  

case(opcode)    
  'b0000: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 1;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end
			 end
  'b0001: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 1;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				ImmVal	= 0;      
			 end  
  'b0010: begin					
				RegWrite	= 1;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				ImmVal	= 0;      
			 end
  'b0011: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end
  'b0100: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0101: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0110: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0111: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1000: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1001: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1010: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1011: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					immVal = 1;
				end else begin
					ImmVal	= 0;
				end;      
			 end
  'b1100: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 1;
				Lookup	= 1;
				ImmVal	= 0;      
			 end

  'b1101: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 1;
				Lookup	= 1;
				ImmVal	= 0;      
			 end

			 
  'b1110: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 0;
				Branch	= 1;
				Lookup	= 1;
				ImmVal	= 0;      
			 end

  'b1111: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Start		= 0;
				Done		= 1;
				Branch	= 0;
				Lookup	= 0;
				ImmVal	= 0;      
			 end


// ...
endcase

end
	
endmodule