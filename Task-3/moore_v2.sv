// Derived from Quartus Prime Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes. (State
// transitions are synchronous.)

// note: i could have used 2 always_ff blocks (one to update the states and another to transistion between the states)
// but since the template given has only 1 always_ff block i am assuming we would need to think in terms of reducing the space occupied on the chip rather than thinking of the time it will take
// to get an output therfore 1 always_ff block will be used, meaning the output will take 2 clock cycles to appear since 1 clk cycle will be for the state transitioning and the one after will be to update the states


module moore_v2(output logic Y, input logic X, clk, n_reset);

  // Declare state register - TO BE UPDATED
  typedef enum int unsigned { S0 = 1, S1 = 2, S2 = 4, S3 = 8, S4 = 16, S5 = 32} state_t;
  state_t state, NS;

  //minimised state machine, the states in which were minimised are S2 and S4


  // Output depends only on the state - NEED TO BE UPDATED
  always_comb 
  begin // now after minimising states by removing S2 and S4 due to their redundancy , the only states to give Y high are {S1, S5}
    case (state)
      S0:
        Y = 0;
      S1:
        Y = 1;
      S3:
        Y = 0;
      S5:
        Y = 1;
      default:
        Y = 0;
      endcase
   end

  // Determine the next state - NEEDS TO BE UPDATED
  always_ff @(posedge clk or negedge n_reset) 
  begin
    if (n_reset == 1'b0) begin // this will be only true if the n_reset was 0
      state <= S0; // if the condition above was met it will set the current state to S0
    end
    else
      case (state)
        S0: NS <= S1; // this will turn into : S0: NS <= (X == 1) ? S0self : S1;
        S1: NS <= (X == 1) ? S3 : S1;  
        // due the removal of S4, S2 will turn into / S2: NS <= (X == 1) ? S3 : S2self; / which does the same thing as S1 /S1: NS <= (X == 1) ? S3 : S1self;  /
        // therfore remove S2 as well
        S3: NS <= (X == 1) ? S0 : S5;
        // remove S4 cause it is the exact copy of S3
        S5: NS <= S0;
         default  NS <= S0; // default state is S0
      endcase
	state <= NS;
    end
endmodule