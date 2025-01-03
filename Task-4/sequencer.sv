module sequencer(
	input logic RESET,
	input logic CLK,
	input logic valid,
	output logic en_high,
	output logic en_low,
	output logic op_valid
);
typedef enum int unsigned {S0 = 000, S1 = 001, S2 = 010} state_t;
state_t CS, NS;
// Internal signals - YOU MUST USE THESE AS OUTPUTS
logic _en_high, _en_low, _op_valid;

// Simulates the delays
assign #(10ns) en_high = _en_high;
assign #(10ns) en_low  = _en_low;
assign #(10ns) op_valid = _op_valid;

//********************************
// MODIFY THE CODE BELOW THIS LINE
//********************************

// using 2 always_ff blocks(one to update the states and another to trinsition between the states) and an always_comb block to give outputs immediately

always_ff @(posedge CLK or negedge RESET) begin : UPDATE_STATE;


	case (CS)
		S0: NS = (valid == 1'b1) ? S1: S0; // begins at S0 if {valid == 1} it will go to S1 if not it will keep loooping in S0 with no outputs, as soon as valid == 1 it will set en_high to 1
		S1: NS = S2; // when it arrives at S1 it will set back en_high to 0 and now en_low will go 1, and on the next rising edge it will go to S2
		S2: NS = (valid == 1'b0) ? S0: S2; // when arriving at S2 , its next move will depend on the input valid, if valid == 0 it will go back to S0 , if valid was 1 it will keep looping at S2
		default: begin
			NS <= S0;
		end
	endcase
end

always_ff @(posedge CLK or negedge RESET) begin : UPDTAE_STATE;
	if (RESET == 1'b0) begin
		CS <= S0;
	end else begin
		CS <= NS; // sets the NS to be the CS
	end
end


always_comb begin : OUTPUTS;
	case (CS)
		S0: {_en_high, _en_low, _op_valid } = (valid == 1'b1) ? 3'b100 : 3'b000; // at S0, if valid was 0 it will give no outputs , however if valid goes high before going to S1 the output en_high will go high for a small period of time and will remain high untill it arrives at S1
		S1: {_en_high, _en_low, _op_valid } = 3'b010 ; // when it arrives at S1 it will set back en_high to 0 and now en_low will go 1
		S2: {_en_high, _en_low, _op_valid } = 3'b001; // at S2 it will set en_low back to 0 and will set op_valid to 1. Also, as long as it is still at S2 it will keep op_valid == 1
		default:
			{_en_high, _en_low, _op_valid } = 3'b000; // if none if the above cases were met it will set the 3 outputs to 0
	endcase
end

endmodule

