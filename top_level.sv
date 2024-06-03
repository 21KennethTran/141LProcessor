// sample top level design
module top_level(
  input        		clk; 
  output logic 		done);
  parameter 			D = 12,             			// program counter width
							A = 4;              			// ALU command bit width
  wire[D-1:0] 			target, 			  				// jump 
							prog_ctr;

  wire        			RegWrite,						// for control
							AccWrite,
							MemRead,
							MemWrite,
							Start,
							Done,
							Branch,
							Lookup,
							immVal;
							
  wire[7:0]   			acc_out,reg_out,		  		// from RegFile 
							rslt,								// alu output
							mem_out;               		// datamem output

  
  wire[3:0]				opcode;							// opcode from machine code
  wire					identifier;						// identifier for opcode
  wire[3:0]				operand;							// operand from machine code
  wire[8:0]   			mach_code;          			// machine code
  wire[2:0] 			inReg,				    		// address pointers to reg_file
  
  
  
// fetch subassembly
  PC #(.D(D)) 					  							// D sets program counter width
     pc1 (
			.Start,
         .clk,
			.Done,
			.Branch,
			.target,
			.prog_ctr);

// lookup table to facilitate jumps/Branches
  PC_LUT #(.D(D))
    pl1 (.addr  (how_high),
         .target          );   

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);

// control decoder
  Control ctl1(
		.opcode(mach_code[8:5]),
		.identifier(mach_code[4]), 
		.RegWrite, 
		.AccWrite, 
		.MemRead, 
		.MemWrite,     
		.Start,
		.Done,
		.Branch,
		.Lookup,
		.ImmVal);

  assign operand = mach_code[3:0];
  assign identifier = mach_code[4];
  assign opcode  = mach_code[8:5];

  reg_file #(.pw(3)) rf1(
					.dat_in(AccWrite ? mem_out: rslt),	   			// result from ALU OR from datamem
					.clk,
					.ImmVal,
					.AccWrite,
					.RegWrite,
					.addr(operand),      									// in place operation
					.acc_out,
					.reg_out); 


  alu alu1(
			.opcode,
         .identifier,
			.inAcc(acc_out),
			.inReg(reg_out),   							// output from reg_file
			.rslt);  

			
  dat_mem dm1(
			.dat_in(rslt)  ,  					// from from ALU
         .clk           ,
			.MemRead,
			.MemWrite,
			.addr(acc_out),
         .dat_out(mem_out));

// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= pari;
	zeroQ <= zero;
    if(sc_clr)
	  sc_in <= 'b0;
    else if(sc_en)
      sc_in <= sc_o;
  end

  assign done = prog_ctr == 128;
 
endmodule