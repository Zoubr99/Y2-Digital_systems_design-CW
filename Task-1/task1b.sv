module task1b (
   output logic P, 	//P output
   output logic Q, // Q output
   input  logic A,B,C    //Inputs A,B,C
);
// using behavioural style
always_comb begin
// this combinational logic changes the putput as soon as the input is changed
// it uses cases to indicate the inputs and the outputs at each case according to the truth table
// 3 inputs (A,B,C) , depending on the combination of inputs a combianation of ouputs will be given (P,Q)
case({A,B,C})
3'b000 : {P,Q} = 2'b01; // as the first case outputs a dont care at the Q output, an output of 1 was used to help simplify the table
3'b001 : {P,Q} = 2'b11; //
3'b010 : {P,Q} = 2'b01; //
3'b011 : {P,Q} = 2'b00; //
3'b100 : {P,Q} = 2'b10; //
3'b101 : {P,Q} = 2'b10; //
3'b110 : {P,Q} = 2'b00; //
3'b111 : {P,Q} = 2'b00; //
  
endcase


end


endmodule