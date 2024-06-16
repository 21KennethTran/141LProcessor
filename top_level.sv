// sample top level design
module top_level(
  input        		clk,
  input					Start, 
  output logic 		done
  );
  parameter 			D = 12,             			// program counter width
							A = 4;              			// ALU command bit width
  wire[D-1:0] 			target; 			  				// jump 
  wire[D-1:0]			prog_ctr;

  wire        			RegWrite;						// for control
  wire					AccWrite;
  wire					MemRead;
  wire					MemWrite;
//  wire					Start;
  wire					Done;
  wire					Branch;
  wire					Lookup;
  wire					ImmVal;
							
  wire[7:0]   			acc_out;
  wire[7:0]				reg_out;		  					// from RegFile 
  wire[7:0]				rslt;								// alu output
  wire[7:0]				mem_out;               		// datamem output

  
  wire[3:0]				opcode;							// opcode from machine code
  wire					identifier;						// identifier for opcode
  wire[3:0]				operand;							// operand from machine code
  wire[8:0]   			mach_code;          			// machine code
  wire[2:0] 			inReg;				    		// address pointers to reg_file
  
  
  
// fetch subassembly
  PC #(.D(D)) 					  							// D sets program counter width
     pc1 (
			.Start(Start),
         .clk(clk),
			.Done(Done),
			.Branch(Branch),
			.target(target),
			.prog_ctr(prog_ctr)
			);

// lookup table to facilitate jumps/Branches
  PC_LUT #(.D(D))
    pl1 (.addr  (rslt),
//			.Lookup(Lookup),
//			.Branch(Branch),
         .target(target)
			);   

// contains machine code
  instr_ROM ir1(
		.prog_ctr(prog_ctr),
      .mach_code(mach_code)
		);

// control decoder
  Control ctl1(
		.opcode(mach_code[8:5]),
		.identifier(mach_code[4]), 
		.RegWrite(RegWrite), 
		.AccWrite(AccWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite),     
		.Done(Done),
		.Branch(Branch),
		.Lookup(Lookup),
		.ImmVal(ImmVal)
		);

  assign operand = mach_code[3:0];
  assign identifier = mach_code[4];
  assign opcode  = mach_code[8:5];

  reg_file #(.pw(3)) rf1(
					.dat_in(rslt),	   										// from ALU
					.clk(clk),
					.ImmVal(ImmVal),
					.AccWrite(AccWrite),
					.RegWrite(RegWrite),
					.Branch(Branch),
					.addr(operand),      									// in place operation
					.acc_out(acc_out),
					.reg_out(reg_out)
					); 


  alu alu1(
			.opcode(opcode),
         .identifier(identifier),
			.inAcc(acc_out),
			.inReg(MemRead ? mem_out: reg_out),   							// if we are reading from mem, get dat_mem, else get imm value or register value from rf1
			.rslt(rslt)
			);  

			
  dat_mem dm1(
			.dat_in(rslt),  					// from from ALU
         .clk(clk),
			.MemRead(MemRead),
			.MemWrite(MemWrite),
			.addr(acc_out),
         .dat_out(mem_out)
			);

  assign done = prog_ctr == 128;
 
endmodule