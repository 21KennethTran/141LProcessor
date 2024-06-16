module PC_LUT #(parameter D=12)(
  input       		[7:0]addr,	   // target 4 values
//  input				Lookup,
//  output	logic		Branch,
  output logic[D-1:0] target);

  // absolute jumps
  always_comb begin
//	  if (Lookup) begin
		  case(addr)
			0: begin
//				Branch = 0;
				target = 0;	// default
				end
			1: begin
//				Branch = 1;
				target = 17;   	// Program 1
				end
			2: begin
//				Branch = 1;
				target = 30;
				end
			3: begin
//				Branch = 1;
				target = 54;
				end
			4: begin
//				Branch = 1;
				target = 76;
				end
			5: begin
//				Branch = 1;
				target = 85;
				end
			6: begin
//				Branch = 1;
				target = 88;
				end
			7: begin
//				Branch = 1;
				target = 91;
				end
			8: begin
//				Branch = 1;
				target = 19;		// default
				end
			9: begin
//				Branch = 1;
				target = 34;		// default
				end
			10: begin
//				Branch = 1;
				target = 87;		// default
				end
			11: begin
//				Branch = 1;
				target = 112;		// default
				end
			12: begin
//				Branch = 1;
				target = 122;		// default
				end
			13: begin
//				Branch = 1;
				target = 127;		// default
				end
			14: begin
//				Branch = 1;
				target = 132;		// default
				end
			15: begin
//				Branch = 1;
				target = 1;		// default
				end
			default: begin
//				Branch = 0;
				target = 'b0;  // hold PC  
				end
		  endcase
//		 end
//		 else begin
//			Branch = 0;
//			target = 0;
//		end
	 end

endmodule

