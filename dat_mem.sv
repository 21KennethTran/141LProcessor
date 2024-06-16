// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input		 MemRead,				// read enable
  input      MemWrite,	         // write enable
  input[7:0] addr,		      // address pointer
  output logic[7:0] dat_out);

  logic[7:0] core[256];       // 2-dim array  8 wide  256 deep
  initial
	$readmemb("test0.txt", core);

// reads are combinational; no enable or clock required
//  assign dat_out = core[addr];
  always_comb begin
		if (MemRead)
			dat_out = core[addr];
		else
			dat_out = 8'bZ; 	// not sure what this should be
  end

// writes are sequential (clocked) -- occur on stores or pushes 
  always_ff @(posedge clk) begin
    if(MemWrite)				  		// MemWrite usually = 0; = 1 		
      core[dat_in] <= addr; 		// addr holds accumulator value, dat_in (from ALU) is where in memory we want to write to
  end
endmodule