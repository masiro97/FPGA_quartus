module L4part5(A1,A0,B1,B0,LEDG,LEDR,HEX7, HEX6, HEX5, HEX4, HEX2, HEX1, HEX0);
	input [3:0] A1,A0,B1,B0;
	output [8:0] LEDG;
	output [17:0] LEDR = 0;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX2, HEX1, HEX0;
	
	display_7seg h0(A1,HEX7);
	display_7seg h1(A0,HEX6);
	display_7seg h2(B1,HEX5);
	display_7seg h3(B0,HEX4);
	
	wire e1, e2, e3, e4;

  comparator_3bit C0 (B0, e1);
  comparator_3bit C1 (B1, e2);
  comparator_3bit C2 (A0, e3);
  comparator_3bit C3 (A1, e4);
  
  assign LEDG[8] = e1 | e2 | e3 | e4;
  
  wire c1, c2, c3;
  wire [4:0] S0;

  FA FA0 (A0[0], B0[0], 0, S0[0], c1);
  FA FA1 (A0[1], B0[1], c1, S0[1], c2);
  FA FA2 (A0[2], B0[2], c2, S0[2], c3);
  FA FA3 (A0[3], B0[3], c3, S0[3], S0[4]);

  assign LEDG[3:0] = S0[3:0];
  
  wire z0;
  wire [3:0] T0, M0;

  comparator_4bit C4 (S0[4:0], z0);
  circuitA a0 (S0[3:0], T0);
  mux m0 (z0, S0[3:0], T0, M0);
  //circuitB BB (z, HEX1);
  display_7seg H0 (M0, HEX0);

  wire c4, c5, c6;
  wire [4:0] S1;

  FA FA4 (A1[0], B1[0], z0, S1[0], c4);
  FA FA5 (A1[1], B1[1], c4, S1[1], c5);
  FA FA6 (A1[2], B1[2], c5, S1[2], c6);
  FA FA7 (A1[3], B1[3], c6, S1[3], S1[4]);

  assign LEDG[7:4] = S1[3:0];

  wire z1;
  wire [3:0] T1, M1;

  comparator_4bit C5 (S1[4:0], z1);
  circuitA a1 (S1[3:0], T1);
  mux m1 (z1, S1[3:0], T1, M1);
  circuitB b (z1, HEX2);
  display_7seg H1 (M1, HEX1);
  
endmodule

module circuitB (z, HEX);

  input z;
  output [0:6] HEX;

  assign HEX = (z == 1'b0) ? 7'b0000001:7'b1001111;
  
endmodule


module circuitA (V, A);
  input [3:0] V;
  output [3:0] A;

  assign A[0] = V[0];
  assign A[1] = ~V[1];
  assign A[2] = (~V[3] & ~V[1]) | (V[2] & V[1]);
  assign A[3] = (~V[3] & V[1]);
  
endmodule

module mux(z,U,V,M);

 //if z = 0 U z = 1 V
 input z;
 input [3:0]U,V;
 output [3:0]M;
 
// assign M = (z == 1'b0) ? U: V;
 assign M[0] = (z & V[0]) | (~z & U[0]);
 assign M[1] = (z & V[1]) | (~z & U[1]);
 assign M[2] = (z & V[2]) | (~z & U[2]);
 assign M[3] = (z & V[3]) | (~z & U[3]);

endmodule


module display_7seg(sw,HEX);

	input[3:0] sw;
	output [0:6]HEX;
	
	assign HEX = (sw == 4'b0000) ? 7'b0000001: //0
					 (sw == 4'b0001) ? 7'b1001111: //1
					 (sw == 4'b0010) ? 7'b0010010: //2
					 (sw == 4'b0011) ? 7'b0000110: //3
					 (sw == 4'b0100) ? 7'b1001100: //4
					 (sw == 4'b0101) ? 7'b0100100: //5
					 (sw == 4'b0110) ? 7'b0100000: //6
					 (sw == 4'b0111) ? 7'b0001101: //7
					 (sw == 4'b1000) ? 7'b0000000: //8
					 (sw == 4'b1001) ? 7'b0000100: //9
											 7'b1111111;
	
endmodule


module FA(a,b,cin,s,cout);

	input a,b,cin;
	output s,cout;
	
	assign cout = (b & cin) | (a & cin) | (a & b);
	assign s = a ^ b ^ cin;

endmodule

module comparator_3bit (V, z);

  input [3:0] V;
  output z;

  assign z = (V[3] & (V[2] | V[1]));
  
endmodule

module comparator_4bit (V, z);

  input [4:0] V;
  output z;

  assign z = V[4] | ((V[3] & V[2]) | (V[3] & V[1]));
  
endmodule


