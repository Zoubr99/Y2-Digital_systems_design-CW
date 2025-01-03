/*
-------
   x
  ---
s 0 1 y
-------
0 1 2 0
1 1 3 1
2 2 4 1
3 5 0 0
4 5 0 0
5 0 0 1
-------
*/

module moore_tb;

logic clk = 1'b1;
logic n_reset = 1'b0;
logic x, y1;

// instantiating both the minimised and non minimised state machines to be tested using the same test bench since they both should be functioning the same way
// and giving the same outputs
moore_v1 u1(y1,x,clk, n_reset);
moore_v2 u2(y2,x,clk, n_reset);

//generate reset
initial begin
 n_reset = 0;
 #10ps
 n_reset = 1;
end
//
//generate clock
initial begin
 clk = 0;
	
	repeat(50)begin
	#5ps clk = ~clk;
	end

end

//Test vectors
// the checking will be testing both the modules at the same time
initial begin
    //wait for x and n_reset to initialize
	//initial state :- S0
    #5ps
    assert(y1 === 1'b0) $display("passed"); else $error("Failed");
    assert(y2 === 1'b0) $display("passed"); else $error("Failed");
    #5ps

    // now after 10 ps which is the time taken to set the n_reset to 1, it will need to process S0 first so on the next rising clk edge it will transition to S0, therfore :
    // since i am only using 1 always flip flop (less space but time consuming) it will take 1 rising edge to transition states and another rising edge to set the NS to be current state (update the state) where then i can observe the output :
    // hence the time it will take = ( 10ps the transition delay ) + (10 ps updating the states) = 20 ps
    // so after setting the n_reset to 1 we will need to go through S0 first which will take 20ps in total to see its ouput
    #20ps
    assert(y1 === 1'b0) $display("passed"); else $error("Failed");
    assert(y2 === 1'b0) $display("passed"); else $error("Failed");

    // now after going thorugh S0 we can move to S1
    // setting X = 0 transitions to S1 and the output should be 1
    //testing S1
    x = 1'b0;
    #20ps
    assert(y1 === 1'b1) $display("passed"); else $error("Failed");
    assert(y2 === 1'b1) $display("passed"); else $error("Failed");

    //while at S1, if X was 0 it will keep looping in the same state 'S1' and output 1
    // testing S1
    x = 1'b0;
    #20ps
    assert(y1 === 1'b1) $display("passed"); else $error("Failed");
    assert(y2 === 1'b1) $display("passed"); else $error("Failed");
  

    // However when setting X to be 1 it will go from S1 to S3 therfore the output should be 0
    // testing S3
    x = 1'b1;
    #20ps
    assert(y1 == 1'b0) $display("passed"); else $error("Failed");
    assert(y2 == 1'b0) $display("passed"); else $error("Failed");


    // from this state we have two paths either go to (S0 if X = 1) or got to (S5 if X = 0) , now will test just  (S5 if X = 0) , output should be 1
    // testing S5
    x = 1'b0;
    #20ps
    assert(y1 == 1'b1) $display("passed"); else $error("Failed");
    assert(y2 == 1'b1) $display("passed"); else $error("Failed");
   

    //at S5 the input dosent matter it will go to S0 in both casses , so will do x = 1
    //testing S0
    x = 1'b1;
    #20ps
    assert(y1 == 1'b0) $display("passed"); else $error("Failed");
    assert(y2 == 1'b0) $display("passed"); else $error("Failed");
    

    // now we are in the initial state again S0, lets try taking another path, by setting X = 1 instead of zero, out = 1
    //testing S2
    x = 1'b1;
    #20ps
    assert(y1 == 1'b1) $display("passed"); else $error("Failed");
    assert(y2 == 1'b1) $display("passed"); else $error("Failed");
    

    //at S2 if X = 0 it will loop in S2 if X =1 it will transition to S4 , lets try looping
    //testing S2 
    x = 1'b0;
    #20ps
    assert(y1 == 1'b1) $display("passed"); else $error("Failed");
    assert(y2 == 1'b1) $display("passed"); else $error("Failed");
    

    //now lets move on to S4 by setting X to 1 , out @ S4 = 0 
    // here S4 does the same as S3 before, therfore it could be minimised but lets leave till the next task
    // note that it will give same output , cause on the minimized machine this state is considered S3 and not S4
    //testing S4
    x = 1'b1;
    #20ps
    assert(y1 == 1'b0) $display("passed"); else $error("Failed");
    assert(y2 == 1'b0) $display("passed"); else $error("Failed");
   

    // now lets go to S5
   //testing S5
    x = 1'b0;
    #20ps
    assert(y1 == 1'b1) $display("passed"); else $error("Failed");
    assert(y2 == 1'b1) $display("passed"); else $error("Failed");
    
    
    //at S5 the input dosent matter it will go to S0 in both casses , so will do x = 1
    //testing S0
    x = 1'b1;
    #20ps
    assert(y1 == 1'b0) $display("passed"); else $error("Failed");
    assert(y2 == 1'b0) $display("passed"); else $error("Failed");

end

endmodule


