// my do-nothing dummy DUT
// has correct input pins and output pin
// has correct data_mem core
// has program counter that at least behaves properly
module DUT(
  input clk   ,
        start ,
  output logic done);

  logic      wen;     // data_mem write enable
  logic[7:0] addr,    // data_mem address pointer
             dat_in,  // data_mem data ports
           	 dat_out, //   "
			 prog_ct; // program counter (>8 bits is fine)

// instantiate data memory
  dat_mem dm(
    .clk,
	.wen,
    .addr,
    .dat_in,
    .dat_out);

  always_ff @(posedge clk)
    if(start) prog_ct <= 'd0;
	else      prog_ct <= prog_ct + 'd1;


// drive from either program counter (easy) or 
//   machine code
  always_comb done = prog_ct == 'd10;  

endmodule