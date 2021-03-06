module BlackJack(sw,key,clk,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);

	input [17:0]sw;
	input [3:0]key;
	input clk;
	output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	output reg[17:0] LEDR;
	
	reg [3:0] myCard1,myCard2,myCard3,myCard4,myCard5,myCard6;
	reg [3:0] deCard1,deCard2,deCard3,deCard4,deCard5,deCard6;
	reg [3:0] rand1,rand2,rand3,rand4,rand5,rand6;
	reg [2:0] result;
	reg [4:0] score; //1 : lose 2: win 3: draw 4: blackjack win
	wire [3:0] rand0;
	wire [3:0] isAto11;
	wire isHaveA;
	wire [4:0] mySum,deSum,mySumofSub,deSumofSub;
	wire [23:0] myCard,deCard;

	assign myCard = (result != 0) ? 0 :{myCard1,myCard2,myCard3,myCard4,myCard5,myCard6};
	assign deCard = (result != 0) ? 0 :{deCard1,deCard2,deCard3,deCard4,deCard5,deCard6};
	
	assign isHaveA = myCard1 == 1 | myCard2 == 1 | myCard3 == 1|
							myCard4 == 1 | myCard5 ==1 | myCard6 == 1;
							
	assign isAto11 = (sw[17] == 1 & isHaveA) ? 10 : 0;
	
	randomGenerator r0(clk,key,rand0);
	
	calSumOfSub c0(myCard,mySumofSub);
	calSumOfSub c1(deCard,deSumofSub);
	
	assign mySum = myCard1 + myCard2 + myCard3 + myCard4 + myCard5 + myCard6
							+isAto11 - mySumofSub;
							
	assign deSum = deCard1 + deCard2 + deCard3 + deCard4 + deCard5 + deCard6
						- deSumofSub;
						 
	display_7seg d0(deCard[15:12],sw[16],result,HEX0);
	display_7seg d1(deCard[19:16],sw[16],result,HEX1);
	display_7seg d2(deCard[23:20],sw[16],result,HEX2);
	display_7seg d3(myCard[7:4],sw[16],result,HEX3);
	display_7seg d4(myCard[11:8],sw[16],result,HEX4);
	display_7seg d5(myCard[15:12],sw[16],result,HEX5);
	display_7seg d6(myCard[19:16],sw[16],result,HEX6);
	display_7seg d7(myCard[23:20],sw[16],result,HEX7);
	
	initial begin
	
		myCard1 = 0; myCard2 = 0; myCard3 = 0;
		myCard4 = 0; myCard5 = 0; myCard6 = 0;
		deCard1 = 0; deCard2 = 0; deCard3 = 0;
		deCard4 = 0; deCard5 = 0; deCard6 = 0;
		rand1 = 0; rand2 = 0; rand3 = 0; rand4 = 0;
		result = 0; score = 0; LEDR = 0;
	
	end
	
	integer i = 0;
	//integer j = 0;
	
	always @(posedge sw[16]) begin
	
			if(result != 0)begin
				if(result == 1) begin
					if(score > 0) score = score -1;
				end
				else if(result == 2) score = score + 1;
				else if(result == 3) score = score;
				else if(result == 4) score = score + 2;
				
			end
			for(i=0;i<18;i=i+1) begin
				if(i == score) LEDR[i] = 1;
				else LEDR[i] = 0;
			end
	end
	
	always @(posedge clk) begin
		
		if(key[1] ==0) begin
			result = 0;
			
			myCard1 = rand1;
			myCard2 = rand2;
			deCard1 = rand3;
			deCard2 = rand4;
			
			myCard3 = 0; myCard4 = 0;
			myCard5 = 0; myCard6 = 0;
			deCard3 = 0; deCard4 = 0;
			deCard5 = 0; deCard6 = 0;
			
		end
		
		else if(key[2] == 0) begin //hit
		
			if(sw[0] == 1) begin
			
				if(mySum == 21) result = 4;
				else if(mySum > 21) result = 1;
				else if(deSum > 21) result = 2;
				else if(mySum == deSum) result = 3;
				else if(mySum > deSum) result = 2;
				else result = 1;
			
			end
			
			if(sw[1] == 1) begin
			
				myCard3 = rand5;
				deCard3 = rand6;
				
				if(mySum == 21) result = 4;
				else if(mySum > 21) result = 1;
				else if(deSum > 21) result = 2;
				else if(mySum == deSum) result = 3;
				else if(mySum > deSum) result = 2;
				else result = 1;
			end
			
			else if(sw[2] == 1) begin
				myCard4 = rand5;
				deCard4 = rand6;
				
				if(mySum == 21) result = 4;
				else if(mySum > 21) result = 1;
				else if(deSum > 21) result = 2;
				else if(mySum == deSum) result = 3;
				else if(mySum > deSum) result = 2;
				else result = 1;
			end
			
			else if(sw[3] == 1) begin
				myCard5 = rand5;
				deCard5 = rand6;
				
				if(mySum == 21) result = 4;
				else if(mySum > 21) result = 1;
				else if(deSum > 21) result = 2;
				else if(mySum == deSum) result = 3;
				else if(mySum > deSum) result = 2;
				else result = 1;
			end
			
			else if(sw[4] == 1) begin
			
				myCard6 = rand5;
				deCard6 = rand5;
				
				if(mySum == 21) result = 4;
				else if(mySum > 21) result = 1;
				else if(deSum > 21) result = 2;
				else if(mySum == deSum) result = 3;
				else if(mySum > deSum) result = 2;
				else result = 1;
				
			end						
		end
		
	end
	
	always @(negedge key[1], negedge key[2]) begin
		
		if(key[1] == 0) begin
			
			rand1 = rand0 % 13 + 1;
			rand2 = (rand0 + 23) % 13 + 1;
			rand3 = (rand0 + 33) % 13 + 1;
			rand4 = (rand0 + 43) % 13 + 1;
		
		end
		
		if(key[2] == 0)begin
	
			rand5 = rand0 % 13 + 1;
			rand6 = (rand0 + 25) % 13 + 1;
			
		end

	end

endmodule

module randomGenerator(clk,key,randResult);

	input clk;
	input [3:0]key;
	output [3:0]randResult;
	
	reg [26:0] cnt;
	reg [3:0] randTemp;
	
	initial begin
		randTemp = 0;
		cnt = 0;
	end
	
	always @(posedge clk) begin
	
		if(key[1] == 0 | key[2] == 0 | key[3] == 0) cnt = cnt + 1;
		else randTemp = cnt % 15 + 1;
		
		if(cnt == 50000000) cnt = 0;
		
	end

	assign randResult = randTemp;
	
endmodule


module calSumOfSub(card,sumOfSub);
	input [23:0] card;
	output [4:0] sumOfSub;
	
	wire [1:0]c1,c2,c3,c4,c5,c6;
	
	assign c1 = (card[3:0] == 11) ? 1:
					(card[3:0] == 12) ? 2:
					(card[3:0] == 13) ? 3: 0;
					
	assign c2 = (card[7:4] == 11) ? 1:
					(card[7:4] == 12) ? 2:
					(card[7:4] == 13) ? 3: 0;
					
	assign c3 = (card[11:8] == 11) ? 1:
					(card[11:8] == 12) ? 2:
					(card[11:8] == 13) ? 3: 0;
					
	assign c4 = (card[15:12] == 11) ? 1:
					(card[15:12] == 12) ? 2:
					(card[15:12] == 13) ? 3: 0;				
					
	assign c5 = (card[19:16] == 11) ? 1:
					(card[19:16] == 12) ? 2:
					(card[19:16] == 13) ? 3: 0;
					
	assign c6 = (card[23:20] == 11) ? 1:
					(card[23:20] == 12) ? 2:
					(card[23:20] == 13) ? 3: 0;
					
	assign sumOfSub = c1 + c2 + c3 + c4 + c5 + c6;

endmodule

module sum_card (sum,sw,isHaveA,sumOfSub,result);
	
	input [4:0] sum;
	input sw,isHaveA;
	input [3:0] sumOfSub;
	output [4:0] result;
	
	wire [3:0] c;
	assign c = (sw == 1 & isHaveA == 1) ? 10 : 0;
	assign result = sum - sumOfSub + c;

endmodule

module display_7seg(sw,cntl,res,HEX);

   input[3:0] sw;
	input [2:0] res;
	input cntl;
   output [0:6]HEX;
   
   assign HEX = (sw == 4'b0001 && cntl == 0) ? 7'b0001000: //A
                (sw == 4'b0010 && cntl == 0) ? 7'b0010010: //2
                (sw == 4'b0011 && cntl == 0) ? 7'b0000110: //3
                (sw == 4'b0100 && cntl == 0) ? 7'b1001100: //4
                (sw == 4'b0101 && cntl == 0) ? 7'b0100100: //5
                (sw == 4'b0110 && cntl == 0) ? 7'b0100000: //6
                (sw == 4'b0111 && cntl == 0) ? 7'b0001101: //7
                (sw == 4'b1000 && cntl == 0) ? 7'b0000000: //8
                (sw == 4'b1001 && cntl == 0) ? 7'b0000100: //9
                (sw == 4'b1010 && cntl == 0) ? 7'b0001000: //10
                (sw == 4'b1011 && cntl == 0) ? 7'b0100111: //j
                (sw == 4'b1100 && cntl == 0) ? 7'b0001100: //q
                (sw == 4'b1101 && cntl == 0) ? 7'b1111000:
					 (sw >= 4'b1110 && cntl == 0) ? 7'b1111111: //k else nothing
					 (res == 3'b000 && cntl == 1) ? 7'b0000001:
					 (res == 3'b001 && cntl == 1) ? 7'b1001111:
					 (res == 3'b010 && cntl == 1) ? 7'b0010010:
					 (res == 3'b011 && cntl == 1) ? 7'b0000110:
					 (res == 3'b100 && cntl == 1) ? 7'b1001100: 7'b1111111; 
   
endmodule

