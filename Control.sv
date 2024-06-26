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
	output logic		Done,				// stop
	output logic		Branch,			// Branching
	output logic		Lookup,			// lookup table needed; Branch and lookup are the same... need another bit for this?
	output logic		ImmVal			// use immediate value
	
	);

always_comb begin
  
  RegWrite	= 0;
  AccWrite	= 0;
  MemRead	= 0;
  MemWrite	= 0;
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
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end
			 end
  'b0001: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 1;
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
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end
  'b0100: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0101: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0110: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b0111: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1000: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1001: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1010: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end      
			 end

  'b1011: begin					
				RegWrite	= 0;
				AccWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Done		= 0;
				Branch	= 0;
				Lookup	= 0;
				if (identifier) begin
					ImmVal = 1;
				end else begin
					ImmVal	= 0;
				end;      
			 end
  'b1100: begin					
				RegWrite	= 0;
				AccWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
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
				Done		= 1;
				Branch	= 0;
				Lookup	= 0;
				ImmVal	= 0;      
			 end


// ...
endcase

end
	
endmodule