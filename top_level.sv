// sample top level design
module top_level(
  input        		clk, Start, req, 
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
							rslt,               			// alu output


  
  wire[A-1:0] 			opcode;							// opcode
  wire					identifier;  					// identifier for opcode
  wire[8:0]   			mach_code;          			// machine code
  wire[2:0] 			rd_addrA, rd_adrB;    		// address pointers to reg_file
  
  
  
// fetch subassembly
  PC #(.D(D)) 					  							// D sets program counter width
     pc1 (.Start            ,
         .clk              ,
		 .reljump_en (relj),
		 .absjump_en (absj),
		 .target           ,
		 .prog_ctr          );

// lookup table to facilitate jumps/Branches
  PC_LUT #(.D(D))
    pl1 (.addr  (how_high),
         .target          );   

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);

// control decoder
  Control ctl1(.instr(),
  .RegDst  (), 
  .Branch  (relj)  , 
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite   ,     
  .MemtoReg(),
  .ALUOp());

  assign rd_addrA = mach_code[2:0];
  assign rd_addrB = mach_code[5:3];
  assign opcode  = mach_code[8:6];

  reg_file #(.pw(3)) rf1(.dat_in(regfile_dat),	   // loads, most ops
              .clk         ,
              .MemWrite   (RegWrite),
              .rd_addrA(rd_addrA),
              .rd_addrB(rd_addrB),
              .wr_addr (rd_addrB),      // in place operation
              .datA_out(datA),
              .datB_out(datB)); 

  assign muxB = ALUSrc? immed : datB;

  alu alu1(.opcode(),
         .inA    (datA),
		 .inB    (muxB),
		 .sc_i   (sc),   // output from sc register
		 .rslt       ,
		 .sc_o   (sc_o), // input to sc register
		 .pari  );  

  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			 .MemWrite  (MemWrite), // stores
			 .addr   (datA),
             .dat_out());

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