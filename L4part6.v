module L4part6 (A1,A0,B1,B0, LEDG, LEDR, HEX7, HEX6, HEX5, HEX4, HEX2, HEX1, HEX0);
  input [3:0] A1,A0,B1,B0;
  output [8:0] LEDG;
  output [0:6] HEX7, HEX6, HEX5, HEX4, HEX2, HEX1, HEX0;
  output [17:0] LEDR =0;

  reg [4:0] T1, T0;
  reg [3:0] Z1, Z0, S2, S1, S0;
  reg c2, c1;

  always begin
    T0 = B0 + A0;
    if (T0 > 9) begin
      Z0 = 10;
      c1 = 1;
    end else begin
      Z0 = 0;
      c1 = 0;
    end
    S0 = T0 - Z0;

    T1 = B1 + A1 + c1;
    if (T1 > 9) begin
      Z1 = 10;
      c2 = 1;
    end else begin
      Z1 = 0;
      c2 = 0;
    end
    S1 = T1 - Z1;
    S2 = c2;
  end

  display_7seg H0 (S0, HEX0);
  display_7seg H1 (S1, HEX1);
  display_7seg H2 (S2, HEX2);
  display_7seg H4 (B0, HEX4);
  display_7seg H5 (B1, HEX5);
  display_7seg H6 (A0, HEX6);
  display_7seg H7 (A1, HEX7);
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
