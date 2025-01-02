
  // Output depends only on the state - NEED TO BE UPDATED
 // Derived from Quartus Prime Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes. (State
// transitions are synchronous.)

// first, creating the state machine without minimisation

// note: i could have used 2 always_ff blocks (one to update the states and another to transistion between the states so the whole procces would take only 1 clock cycle)
// but since the template given has only 1 always_ff block and it was not mentioned that i could add extra blocks, i am assuming we would need to think in terms of reducing the space occupied on the chip rather than thinking of the time it will take
// to get an output therfore 1 always_ff block will be used, meaning the output will take 2 clock cycles to appear since 1 clk cycle will be for the state transitioning and the one after will be to update the states

module moore_v1(output logic Y, input logic X, clk, n_reset);

  // Declare state register
  typedef enum int unsigned { S0 = 1, S1 = 2, S2 = 4, S3 = 8, S4 = 16, S5 = 32} state_t;
  state_t state, NS;

  // Output depends only on the state - NEED TO BE UPDATED
  always_comb // this the block which will change immediately depending on the state in which the machine is currently in 
  begin       // in this case there are only 2 states that have the output Y high {S1, S2, S5} whereas the rest have the output Y low
    case (state)
      S0:
        Y = 0;
      S1:
        Y = 1;
      S2:
        Y = 1;
      S3:
        Y = 0;
      S4:
        Y = 0;
      S5:
        Y = 1;
      default:
        Y = 0;
      endcase
   end
//
  // Determine the next state - NEEDS TO BE UPDATED
  always_ff @(posedge clk or negedge n_reset) // a flip flop block which will only trigger on 1_ the positive edge of the clk 2_ the negative edge of the reset
  begin
    if (n_reset == 1'b0) begin  // on the negative edge of reset this condition will be true , therfore the state will go back to zero. (Asynchronise) no matter what state the clk is on
      state <= S0;
    end
    else
      case (state) // this state block indicates the next state to be transitioned to from the current state according to the input X
        S0: NS <= (X == 1) ? S2 : S1;
        S1: NS <= (X == 1) ? S3 : S1;  
        S2: NS <= (X == 1) ? S4 : S2;
        S3: NS <= (X == 1) ? S0 : S5;
        S4: NS <= (X == 1) ? S0 : S5;
        S5: NS <= S0;
         default  NS <= S0;  // if none of the cases above were true the next state will be S0
      endcase
	state <= NS;

end
endmodule

