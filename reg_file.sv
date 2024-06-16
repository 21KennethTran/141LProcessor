// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=4)(
  input[7:0] 				dat_in,
  input      				clk,
  input						ImmVal,
  input      				AccWrite,         // write enable to accumulator
  input						RegWrite,			// write enable to reg
  input						Branch,				// see if lookup table used
  input[pw:0] 				addr,		  			// address of register
  output logic[7:0] 		acc_out, 			// read data
								reg_out);

  logic[7:0] core[16];    // 2-dim array  8 wide  16 deep

	// reads are combinational
  assign acc_out = core[0];
  
  // use immediate values or register values
  always_comb begin
		if(ImmVal || Branch) begin
			reg_out = addr;
		end else begin
			reg_out = core[addr];
		end
	end
  

// writes are sequential (clocked)
  always_ff @(posedge clk) begin
		if(AccWrite) begin				   // anything but stores or no ops
			core[0] <= dat_in;
		end else begin
			if(RegWrite)
				core[addr] <= dat_in;
		end
  end

endmodule
