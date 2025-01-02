module task2_tb;

// Add internal signals here
logic clk, reset, n_cen, n_op_en, rel;
logic [15:0] Q;

task2 u1 (Q, rel, clk, n_op_en, n_cen, reset);

//Reset
initial begin
   //Generate reset signal here
   // initialising the reset signal
	reset = 1;
	#5ps
	reset = 0;
	#5ps
	reset = 1;
	// after 10 ps the reset signal will be high
end

//Clock
initial begin
	clk = 0; // initializing clk signal as zero
        repeat(80) #5ps clk = ~clk; // repeating the clock 80 times in steps of 5ps
end


//Input Stimulus
initial begin
   $display("Begin testing");

   //Write testbench here
    n_op_en = 1; // setting out enable to be 1
    #5ps // wait 5 ps and then set n_cen to be 1
    n_cen = 1;
    assert(Q === 16'b000000000000000z) $display("pass"); else $error("Failed"); // since the cut enable(active low) is high it means the output should be high impedance
    #10ps


    // after 15 ps start testing
    n_op_en = 0; // set output enable to 0 which will output the value of count
    n_cen = 0; // set the cEN to be 0 wich will start increasing the value of count
    // it is better to not check on the same edge of setting the inputs, therfore we will wait for half a cycle and then check the output
    #5ps
    assert(Q == 16'b0000000000000001) $display("pass"); else $error("Failed");
    #10ps // after the last check it will take 5ps to increase count therfore we will wait 10 ps to check the next count val
    assert(Q == 16'b0000000000000010) $display("pass"); else $error("Failed"); // check the counter is working as expected

    // now hold the previous count val and :
    n_op_en = 0; // here leave OE low but set CEN to high and check the the count stays as it is as long as the Cen is high
    n_cen = 1;
    // now check the count val is still the same after whtever delay lets try after 20 ps
    #30ps
    assert(Q == 16'b0000000000000010) $display("pass"); else $error("Failed"); // check the count val is still 2

    
    // now set the cen back to 0 and it will continue to increase the count value
    n_op_en = 0;
    n_cen = 0;
    #10ps  // 5 ps delay untill the next rising edge and another 5 ps delay for the check on the negative edge
    assert(Q == 16'b0000000000000011) $display("pass"); else $error("Failed"); // check that the value has now changed to 3
    #10ps
    
    assert(Q == 16'b0000000000000100) $display("pass"); else $error("Failed"); // check the count val is 4
    n_op_en = 0; // here doing the same thing again (holding the Cen high) just for some extra checking
    n_cen = 1;
    // check after 15 ps
    #15ps
    assert(Q == 16'b0000000000000100) $display("pass"); else $error("Failed");

    // wait for 1 full cycle 10ps 
    #10ps
    // now check that the OE is still working as expected if {n_op_en = 1} the output should go high impedance
    n_op_en = 1; // setting the OE high, the output will go high impedance but the counter is still counting
    n_cen = 0;
    #5ps // set the inputs , wait for 5 ps and then check the ouput Q is high impedance
    assert(Q === 16'b000000000000000z) $display("pass"); else $error("Failed"); // check that Q is high impedance
    #20ps

    // now set Q to be count, after 3 rising edges count will have increased and gone from 100 to 111
    n_op_en = 0;
    n_cen = 0;
    #1ps // put a small delay
    //check the output
    assert(Q == 16'b0000000000000111) $display("pass"); else $error("Failed");


    // now after checking the inputs , lets check the REL signal

    #79ps
    //check the count is max
    assert(Q == 16'b0000000000001111) $display("pass"); else $error("Failed");
    
    // now as the max count val has been reached the REL will go high and count will set back to 0
    
    // it will take 5ps till the next rising edge
    // and we want to check on the falling edge after the state changing
    #10 // 5ps + 5ps = 10
    // now check that the count has gone 0
    assert(Q == 16'b0000000000000000) $display("pass"); else $error("Failed");

    // here wait until the next rising edge for the count to start increasing 
    // after the count has increased wait until the next neg edge and then check
    #10ps // 5ps until the next positive edge + 5 ps untill the next negative edge 
    // now check that the count has increased by going from 0000 to 0001
    assert(Q == 16'b0000000000000001) $display("pass"); else $error("Failed");

	

end

endmodule
