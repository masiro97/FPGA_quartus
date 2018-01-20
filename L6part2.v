module L6part2(enable, reset, clk,Q,HEX0,HEX1,HEX2,HEX3);
	input enable,reset,clk; //enable is sw1, reset is sw0
	output reg [15:0] Q;
	output [0:6] HEX0,HEX1,HEX2,HEX3;
	
	always @(posedge clk) begin
		if(reset)
			Q <=0;
		else if(enable)
			Q <= Q + 1;
		else
			Q <= Q;
	end
	
	display_7seg s1(Q[3:0],HEX0);
	display_7seg s2(Q[7:4],HEX1);
	display_7seg s3(Q[11:8],HEX2);
	display_7seg s4(Q[15:12],HEX3);
	
endmodule

module display_7seg(sw,HEX);
	input[3:0] sw;
	output [0:6]HEX;
	
	assign HEX = (sw == 4'b0000) ? 7'b0000001: // showing 0
					 (sw == 4'b0001) ? 7'b1001111: // showing 1
					 (sw == 4'b0010) ? 7'b0010010: // showing 2
					 (sw == 4'b0011) ? 7'b0000110: // showing 3
					 (sw == 4'b0100) ? 7'b1001100: // showing 4
					 (sw == 4'b0101) ? 7'b0100100: // showing 5
					 (sw == 4'b0110) ? 7'b0100000: // showing 6
					 (sw == 4'b0111) ? 7'b0001101: // showing 7
					 (sw == 4'b1000) ? 7'b0000000: // showing 8
					 (sw == 4'b1001) ? 7'b0000100: // showing 9
											 7'b1111111;
endmodule
