// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input		 MemRead,				// read enable
  input      MemWrite,	         // write enable
  input[7:0] addr,		      // address pointer
  output logic[7:0] dat_out);

  logic[7:0] core[256];       // 2-dim array  8 wide  256 deep

// reads are combinational; no enable or clock required
//  assign dat_out = core[addr];
  always_comb begin
		if (MemRead)
			dat_out = core[addr];
		else
			dat_out = 8'bZ; 	// not sure what this should be

// writes are sequential (clocked) -- occur on stores or pushes 
  always_ff @(posedge clk)
    if(MemWrite)				  		// MemWrite usually = 0; = 1 		
      core[addr] <= dat_in; 
endmodule