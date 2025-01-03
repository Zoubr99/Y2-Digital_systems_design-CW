module task1_tb;

// Add internal signals here
logic Pa; // output of P
logic Qa; // output of Q
logic A, B, C; // inputs A, B, C


// instantiating both modules : == the behavioural style module, == the gate level module
task1a u1 (Pa,Qa,A,B,C); // structural HDL
task1b u2 (Pb,Qb,A,B,C);

/// this test bench should test both the modules instantiated above
// they shall give the same oputput 

//Stimulus
initial begin

	{A,B,C} = 3'b000; // setting all the input signals to 0 initially
	#10ps	// a delay of 10ps

	// now checking the outputs
        #10ps;
        {A,B,C} = 3'b000; // setting the inputs to zero
	#10ps; // delay to ensure that the change has taken place
        assert({Pa,Qa} == 2'b01) $display("PASS"); else $error("FAILED"); // checking the outputs of the Structural HDL  if as expected it shoould pass if not it should give an error
	assert({Pb,Qb} == 2'b01) $display("PASS"); else $error("FAILED"); // checking the outputs of the behavioural HDL  if as expected it shoould pass if not it should give an error

	// now , the rest is repeating each combination of the 3 inputs and checking the outputs according to the truth table given:
        #10ps;
        {A,B,C} = 3'b001;
	#10ps;
        assert({Pa,Qa} == 2'b11) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b11) $display("PASS"); else $error("FAILED");

        #10ps;
        {A,B,C} = 3'b010;
	#10ps;
        assert({Pa,Qa} == 2'b01) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b01) $display("PASS"); else $error("FAILED");

        #10ps;
        {A,B,C} = 3'b011;
	#10ps;
        assert({Pa,Qa} == 2'b00) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b00) $display("PASS"); else $error("FAILED");

        #10ps;
        {A,B,C} = 3'b100;
	#10ps;
        assert({Pa,Qa} == 2'b10) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b10) $display("PASS"); else $error("FAILED");

        #10ps;
        {A,B,C} = 3'b101;
	#10ps;
        assert({Pa,Qa} == 2'b10) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b10) $display("PASS"); else $error("FAILED");

        #10ps;
        {A,B,C} = 3'b110;
	#10ps;
        assert({Pa,Qa} == 2'b00) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b00) $display("PASS"); else $error("FAILED");


        #10ps;
        {A,B,C} = 3'b111;
	#10ps;
        assert({Pa,Qa} == 2'b00) $display("PASS"); else $error("FAILED");
	assert({Pb,Qb} == 2'b00) $display("PASS"); else $error("FAILED");




//Write Testbench here

end

endmodule
