module PC_LUT #(parameter D=12)(
  input       [ 3:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  // absolute jumps
  always_comb case(addr)
   0: target = 1;   		// default
	1: target = 18;   	// Program 1
	2: target = 31;
	3: target = 54;
	4: target = 76;
	5: target = 85;
	6: target = 88;
	7: target = 91;
	8: target = 31;		// Program 2
	9: target = 31;
	10: target = 31;
	11: target = 31;
	12: target = 31;
	13: target = 31;
	14: target = 31;
	15: target = 31;
	default: target = 'b0;  // hold PC  
  endcase

endmodule

/*

	   pc = 4    0000_0000_0100	  4
	             1111_1111_1111	 -1

                 0000_0000_0011   3

				 (a+b)%(2**12)


   	  1111_1111_1011      -5
      0000_0001_0100     +20
	  1111_1111_1111      -1  
	  0000_0000_0000     + 0


  */
