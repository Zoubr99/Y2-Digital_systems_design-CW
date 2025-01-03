module system_tb;

  // Declare signals
  logic CLK = 0;
  logic DATA_VALID = 0;
  logic RESET = 0;
  logic [3:0] DATA_IN = 0;
  logic OUTPUT_VALID;
  logic EN_H = 0;
  logic EN_L = 0;
  logic [7:0] DATA_OUT;

  // Instantiate the DUT
  four2eight dut (
    .CLK(CLK),
    .DATA_VALID(DATA_VALID),
    .RESET(RESET),
    .DATA_IN(DATA_IN),
    .OUTPUT_VALID(OUTPUT_VALID),
    .EN_H(EN_H),
    .EN_L(EN_L),
    .DATA_OUT(DATA_OUT)
  );

  // Clock generator
initial begin
	RESET = 'b0;
        #50ns
        RESET = 'b1;
        #50ns
	CLK=0;
  repeat(50)begin 
	   #50ns CLK = ~CLK;
end  
end 
  // Test case: reset
  initial begin
    // Initialize inputs

    // Wait for some time to allow the DUT to settle
    #100ns;

    // Send input data
    DATA_IN = 4'b1111;
    DATA_VALID = 1;
    #100ns
    DATA_IN = 4'b0101; // {adding a diffrent 4 LSB}

    // Wait for some time to allow the DUT to process the data
    #100ns;
     
    // Deassert the data valid signal
    DATA_VALID = 0;

    // Wait for some time to allow the DUT to generate the output
    #100ns;
    assert(DATA_OUT == 8'b11110101) $display("Pass"); else $error("Failed"); // testing the output
  end

endmodule