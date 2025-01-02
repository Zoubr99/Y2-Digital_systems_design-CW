
module task2 #(parameter int N=16'h000F) (
   output logic [15:0] Q, //Counter output
   output logic REL,      //RECYCLE output 
   input logic CLK,       //CLOCK input 
   input logic n_OE,      //Output Enable (active LOW) 
   input n_CEN,           //Count Enable (active LOW)     
   input n_RESET          //Asynchronous RESET (active LOW)
);


logic [N:0]count = 0;




//Write solution here
always_ff @(posedge CLK or negedge n_RESET ) begin : count_status_block // by using a flip flop this will trigger on the positvie edge of the clock or the the negative edge of reset (Asynchronise) active low


      // so, on the negative egde of the reset only this condition will become true and it will set the count back to 0 (Asynchronise) does not get affected by the clock
         if (n_RESET == 0) begin
            count <= 0;
         end

      // the second case is that, on the positive edge of the clock only the condoitions below will be met according to their requirments, since the reset is high.
         else if (n_CEN == 0 && count != N) begin  // after checking the above condition and ensuring that it cannot be met as reset is high, this condition will checck
            count <= count +1 ;                    // if count has not reached the max value N , and the n_count enable is still 0 it will increase count by 1.
         end
         else if (count == N) begin  // if the above condition didnt meet , it will move on to check if the max val of count has been reached it set the count back to 0
            count <= 0;
         end   
         // if none of the conditions above were met meaning that although the count didnt rach the max val, it did not incremant. in this case it means that n_CEN is set high therfore the count will not update
         else count <= count;

end

// always comb block 
always_comb begin

   if (n_OE == 1) begin  // this works like a buffer (Output Enable : Active low) output Q is high impedance when n_OE is high
      Q = 1'bz;
   end 
   else begin  // else (n_OE == 0) output Q is count
		Q = count;
   end 
   
   // here it is not quite clear if this should only go high when it reaches max or it can go high even if reset is set to 0!!!
   if (count == 0) begin // if count == 0 (counter reached max and count is set to 0) REL will go high as long as count is still 0
      REL = 1;
   end
   else begin // whenever count is not 0 REL will go 0
      REL = 0;
   end

end

endmodule 