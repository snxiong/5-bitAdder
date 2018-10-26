// Steven Xiong
// CSC 137 Assignment#3
// Adder.v 5-bit adder
module inputModule;
	parameter STDIN = 32'h8000_0000;
	
	reg [7:0] str [1:4];
	reg [4:0] X, Y;
	output [4:0] S;
	output C5;
	reg [7:0] newline;
	BigAdderMod my_bigAdder(X, Y, S, C5);

	initial begin
	
		$display("Enter X: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);
	
		str[1] = str[1] - 48;
		str[1] = str[1] * 10;
		str[2] = str[2] - 48;
		str[2] = str[2] + str[1];
		X = str[2];
		newline = $fgetc(STDIN);	
	
		$display("Enter Y: ");
		str[3] = $fgetc(STDIN);
		str[4] = $fgetc(STDIN);
		
		str[3] = str[3] - 48;
		str[3] = str[3] * 10;
		str[4] = str[4] - 48;
		str[4] = str[4] + str[3];		

		Y = str[4];
		newline = $fgetc(STDIN);
		
		#1
		$display("X = %d (%b) Y = %d (%b)", X, X, Y, Y);
		$display("Results = %d (%b) C5 = %b", S, S, C5);
	end
endmodule

module BigAdderMod(X, Y, S, C5);
	input [4:0] X, Y;
	output [4:0] S;
	output C5;
	
	wire [4:0] cWire;
	assign cWire[0] = 0;

	FullAdderMod my_fullAdder0(X[0], Y[0], cWire[0], cWire[1], S[0]);
	FullAdderMod my_fullAdder1(X[1], Y[1], cWire[1], cWire[2], S[1]);
	FullAdderMod my_fullAdder2(X[2], Y[2], cWire[2], cWire[3], S[2]);
	FullAdderMod my_fullAdder3(X[3], Y[3], cWire[3], cWire[4], S[3]);
	FullAdderMod my_fullAdder4(X[4], Y[4], cWire[4], C5, S[4]);

//	initial begin
//	#1
	//	$display("C[0] = %b, C[1] = %b, C[2] = %b, C[3] = %b, C[4] = %b, C5 = %b", cWire[0], cWire[1], cWire[2], cWire[3], cWire[4], C5);
	//end	

endmodule

module FullAdderMod(x, y, cin, cout, sum);
	input x, y, cin;
	output cout, sum;
	

	ParityMod my_parity(x, y, cin, sum);
	MajorityMod my_majority(x, y, cin, cout);

endmodule

module ParityMod(x, y, cin, sum);
	input x, y, cin;
	output sum;
	
	wire wireXor;
	
	xor(wireXor, x, y);
	xor(sum, wireXor, cin);
endmodule

module MajorityMod(x, y, cin, cout);
	input x, y, cin;
	output cout;
	wire and0, and1, and2;

	and(and0, x, y);
	and(and1, x, cin);
	and(and2, cin, y);

	or(cout, and0, and1, and2);
endmodule
