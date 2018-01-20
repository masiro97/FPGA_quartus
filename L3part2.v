module L3part2(V,HEX0,HEX1);

	input[3:0] V;
	output [0:6] HEX0,HEX1;
	
	wire z;
	wire [3:0] A,M; //A is m if z = 1
	assign A[3] = 0; // when z = 1, A[3] is always 0
	
	comparator c (V, z); //determine z = 1 or z = 0
	circuitA a (V[2:0],A[2:0]); //if z = 1, determine M( = A)
	mux m (z,V,A,M); // if z = 1 : v = A, z = 0 : V = M
	circuitB b(z,HEX1);// if z = 1 : HEX1 shows 1, z = 0 : HEX1 shows 0
	display_7seg h0(M,HEX0); // HEX0 shows M
	
endmodule

module circuitA(V,A);

	input [2:0] V;
	output [2:0]A;
	
	assign A[0] = V[0];
	assign A[1] = ~V[1];
	assign A[2] = (V[1] & V[2]); 

endmodule

module comparator (V, z);

  input [3:0]V;
  output z;

  assign z = (V[3] & (V[2] | V[1]));
  
endmodule

module circuitB (z, HEX);

  input z;
  output [0:6] HEX;

  assign HEX = (z == 1'b0) ? 7'b1111111:7'b1001111;
  
endmodule

module mux(z,U,V,M);

 input z;
 input [3:0]U,V;
 output [3:0]M;
 
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
