// program counter
// supports absolute jumps
// use either or both, as desired
module PC #(parameter D=12)(
  input 						Start,					// synchronous Start
								clk,
								Done,						// set 'done' flag; is this needed
								Branch,					// Branch enable (jump)
  input       [D-1:0] 	target,					// how far/where to jump
  output logic[D-1:0] 	prog_ctr
);

  always_ff @(posedge clk)
		if(Start)
			prog_ctr <= '0;
		else if(Branch)
			prog_ctr <= target;
		else if(Done)
			prog_ctr <= prog_ctr;
		else
			prog_ctr <= prog_ctr + 'b1;

endmodule