module exx1(sw,HEX0);
	input [3:0]sw;
	output [0:6]HEX0;

	segment(sw,HEX0);
	
endmodule

module segment(sw, seg_data);
	input[3:0]sw;
	output [0:6]seg_data;
	assign seg_data = (sw ==4'b0000) ? 7'b0000001:
					  (sw ==4'b0001) ? 7'b1001111:
					  (sw ==4'b0010) ? 7'b0010010:
					  (sw ==4'b0011) ? 7'b0000110:
					  (sw ==4'b0100) ? 7'b1001100:
					  (sw ==4'b0101) ? 7'b0100100:
					  (sw ==4'b0110) ? 7'b0100000:
					  (sw ==4'b0111) ? 7'b0001101:
					  (sw ==4'b1000) ? 7'b0000000:
					  (sw ==4'b1001) ? 7'b0000100: 7'b1111111;


endmodule
