module Parity2(sw,clk,key,LEDR);

	input [17:0]sw;
	input [3:0]key;
	input clk;
	output [17:0]LEDR;
	
	wire [1:0]r1,r2,r4,r8; //[0]: sw[6:0], [1]: sw[13:7]
	wire [1:0]tr1,tr2,tr4,tr8;
	
	wire [10:0] tbit0,tbit1;
	wire [3:0] error0,error1;
	wire [2:0] swer0,swer1;
	reg [13:0] tsw;
	
	assign LEDR[13:0] = tsw;
	assign LEDR[17:14] = 0;
	
	xor(r1[0],sw[0],sw[1],sw[3],sw[4],sw[6]);
	xor(r1[1],sw[7],sw[8],sw[10],sw[11],sw[13]);
	xor(r2[0],sw[0],sw[2],sw[3],sw[5],sw[6]);
	xor(r2[1],sw[7],sw[9],sw[10],sw[12],sw[13]);
	xor(r4[0],sw[1],sw[2],sw[3]);
	xor(r4[1],sw[8],sw[9],sw[10]);
	xor(r8[0],sw[4],sw[5],sw[6]);
	xor(r8[1],sw[11],sw[12],sw[13]);
	
	xor(tr1[0],r1[0],tsw[0],tsw[1],tsw[3],tsw[4],tsw[6]);
	xor(tr1[1],r1[1],tsw[7],tsw[8],tsw[10],tsw[11],tsw[13]);
	xor(tr2[0],r2[0],tsw[0],tsw[2],tsw[3],tsw[5],tsw[6]);
	xor(tr2[1],r2[1],tsw[7],tsw[9],tsw[10],tsw[12],tsw[13]);
	xor(tr4[0],r4[0],tsw[1],tsw[2],tsw[3]);
	xor(tr4[1],r4[1],tsw[8],tsw[9],tsw[10]);
	xor(tr8[0],r8[0],tsw[4],tsw[5],tsw[6]);
	xor(tr8[1],r8[1],tsw[11],tsw[12],tsw[13]);
	
	assign tbit0 = {tsw[6:4],tr8[0],tsw[3:1],tr4[0],tsw[0],tr2[0],tr1[0]};
	assign tbit1 = {tsw[13:11],tr8[1],tsw[10:8],tr4[1],tsw[7],tr2[1],tr1[1]};
	
	assign error0 = {tr8[0],tr4[0],tr2[0],tr1[0]};
	assign error1 = {tr8[1],tr4[1],tr2[1],tr1[1]};
	
	changeError e0(error0,swer0);
	changeError e1(error1,swer1);
	
	initial tsw = sw;
	
	always @(posedge clk) begin
	
		if(key[0] == 0) begin
		//initialization
		tsw = sw;
		
		end
		if(key[1] == 0) begin //error
			
			tsw[0] = ~sw[0];
			tsw[5] = ~sw[5];
			
		end
		
		if(key[2] == 0) begin
		
			tsw[0] = ~sw[0];
			tsw[12] = ~sw[12];
		
		end
		
		if(key[3] == 0) begin
			if(error0 != 0 & error1 !=0) begin
				tsw[swer0] = ~tsw[swer0];
				tsw[swer1] = ~tsw[swer1];
			end
		end
	
	end
	
	
endmodule

module changeError(error,swer);
	input [3:0]error;
	output [2:0]swer;
	
	assign swer = (error > 8) ? error - 5:
					  (error == 8) ? error:
					  (error > 4) ? error - 4:
					  (error == 4) ? error:
					  (error > 2) ? error - 3:
					  (error ==2 | error == 1) ? error: 7;

endmodule

