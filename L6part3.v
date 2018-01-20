module L6part3(HEX0,clk);

	input clk;
	output [0:6]HEX0;
	wire [3:0] Q;
	
	counter c(clk,Q);
	display_7seg s(Q,HEX0);

endmodule

module counter(clk,Q);
	input clk;
	output reg [3:0]Q;
	reg [25:0]cnt;
	
	initial begin
	cnt = 0;
	Q = 0;
	end
	
	always @(posedge clk) begin 
		cnt = cnt + 1;
		if(cnt == 50000000) begin
			Q = Q + 1;
			cnt = 0;
			if (Q > 9) begin
			Q = 0;
			end
		end
	end

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
