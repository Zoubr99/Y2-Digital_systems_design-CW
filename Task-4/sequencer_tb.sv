module sequencer_tb;

////////////////// note : this TB tests both the sequencer outputs and the system outputs both in one TB raher than testing them speratelty ////////////
// the system_tb  can still be used to test the system , but this Tb has more comenting and it is more clear explaining both the sequencer and the system tb ///// 
logic RESET, CLK, valid, op_valid, en_low, en_high;

logic [3:0] DATA_INd;
logic [7:0] DATA_OUTd;

// instantiating the 2 modules used in the design (to test them both "sequencer and the whole system")
sequencer u1(RESET, CLK, valid, en_high, en_low, op_valid);
data_path u2 (CLK, en_low, en_high, RESET, DATA_INd, DATA_OUTd);

initial begin
	RESET = 'b0;
        #50ns
        RESET = 'b1;
        #50ns
	CLK=0;
  repeat(32)begin 
	   #50ns CLK = ~CLK; // 1 full cycle is 100ns
end  
end 


initial begin
//Write testbench here

    // propagation delay is 10ns 
    DATA_OUTd = 8'b00000000; 
    DATA_INd = 4'b1111;
    valid = 1'b0;
    #200ns



    valid = 1'b1; // set valid high and wait 10 ns till it takes effect and also wait another 10 ns for the output to appear = 20ns
    #10ns
    assert({op_valid, en_low, en_high} === 3'b001) $display("passed"); else $error("Failed");

    // checking the 4 MSB of the data out on the next rising edge 40ns and 1ns so the output takes effect
    #41ns
    assert(DATA_OUTd === 8'b11110000) $display("passed"); else $error("Failed"); 



    //valid = 1'b1; // since the transition is on rising clk edge therfore it will take 51 ns from the moment valid goes high till the system arrives at S1
    // add on top of that 10ns pp delay, However since we are already 50ns late as cause of checking the prev State ouput we can deduct the 51ns 
    #9ns
    assert({op_valid, en_low, en_high} === 3'b010) $display("passed"); else $error("Failed");
    


    // wait 100ns , set valid low since we dont need it high rn
    #40ns
    valid = 1'b0;
    DATA_INd = 4'b1010;
    // lets check the output with the 4 LSB before checking the op_valid
    #51ns
    assert(DATA_OUTd === 8'b11111010) $display("passed"); else $error("Failed"); 



    // so now the system is at state 1, and on the next rising edge after 90ns it will move to S2, however the output would not take effect untill 10ns after arriving at S2
    //valid = 1'b1;
    // therfore (90ns "state transition" + 10ns "pp delay" - 40ns when setting high low - 51 ns for checking the 4LSB of the output)
    #9ns
    assert({op_valid, en_low, en_high} === 3'b100) $display("passed"); else $error("Failed");


    
    // now the system is at state2
    // remember to wait for the next rising edge to state transition, and add pp delay
    // with that being said, since we almost always arrive 10ns late after the rising CLK edge, so it will take 90ns for the next one and 10ns for the pp delay
    // so we could "but not tested for a long time" use a constant delay of 100ns to observe the output we want:
    // now , it will go back to S0 after 90 ns , and the output will be observed after 10ns of arriving at S0
    #100ns
    assert({op_valid, en_low, en_high} === 3'b000) $display("passed"); else $error("Failed");
    #140ns

    // put some data in
    DATA_INd = 4'b1101;
    #100ns
   //now we are at S0 again, so now lets do the same procedure but this time lets hold valid high
   //which will cause the system to keep looping in S2 giving output of 2'b1010
    valid = 1'b1; // set valid high and wait 10 ns till the output takes effect
    #10ns
    assert({op_valid, en_low, en_high} === 3'b001) $display("passed"); else $error("Failed");




    //valid = 1'b1; // since the transition is on rising clk edge therfore it will take 50 ns from the moment valid goes high till the system arrives at S1
    // and since we took 10 ns delay to check thefore i should only have 50 ns to check the next output at S1
    #50ns
    assert({op_valid, en_low, en_high} === 3'b010) $display("passed"); else $error("Failed");
    #40ns
    DATA_INd = 4'b0101;



    // so now the system is at state 1, and on the next rising edge after 90ns it will move to S2, however the output would not take effect untill 10ns after arriving at S2
    // therfore (90ns "state transition" + 10ns "pp delay" - 40 ns when waiting to to set the data in)
    #60ns
    assert({op_valid, en_low, en_high} === 3'b100) $display("passed"); else $error("Failed");
    assert(DATA_OUTd === 8'b11010101) $display("passed"); else $error("Failed"); // checking the output





    // now the system is at state2
    //extra cheekings by changing the state 3 times whilst valid = 1 , which should loop at S2, and output = 3'b100
    // remember to wait for the next rising edge to state transition, and add pp delay
    // with that being said, since we almost always arrive 10ns late after the rising CLK edge, so it will take 90ns for the next one and 10ns for the pp delay
    // so we could "but not tested for a long time" use a constant delay of 100ns to observe the output we want:
    #100ns
    assert({op_valid, en_low, en_high} === 3'b100) $display("passed"); else $error("Failed");


    #100ns
    assert({op_valid, en_low, en_high} === 3'b100) $display("passed"); else $error("Failed");


    #100ns
    assert({op_valid, en_low, en_high} === 3'b100) $display("passed"); else $error("Failed");

   // now setting valid low, it will go back to S0 after 90 ns , and the output will be observed after 10ns of arriving at S0
    valid = 1'b0;
    #100ns
    assert({op_valid, en_low, en_high} === 3'b000) $display("passed"); else $error("Failed");



end

endmodule