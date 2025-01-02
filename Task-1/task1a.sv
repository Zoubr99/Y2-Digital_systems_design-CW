module task1a (
   output logic P, 	//P output
   output logic Q, // Q output
   input  logic A,
   input  logic B,
   input  logic C    //Inputs A,B,C
);
// in wires

wire Ainv; // internal wire connected to the output of the not gate of A 
wire Binv; // internal wire connected to the the output of the not gate of B 
wire Cinv; // internal wire connected to the output of the not gate of C
wire term0; // internal wire to connect 2 wires
wire term1; // internal wire to connect 2 wires
wire term2; // internal wire to connect 2 wires
wire term3; // internal wire to connect 2 wires

not u1 (Ainv, A); // connecting a not gate to the wire of input A and outputing on wire Ainv
not u2 (Binv, B); // connecting a not gate to the wire of input B and outputing on wire Binv
not u3 (Cinv, C); // connecting a not gate to the wire of input C and outputing on wire Cinv


or u4 (term0, A, C); // using wires A and C as inputs to an "or" gate and ouputs the output on the wire term0
and u5 (P, Binv, term0); // using wires Binv and term0 as inputs to an "or" gate and ouputs the output on the wire P



or u7 (term2, Binv, Cinv);  // using wires Binv and Cinv as inputs to an "or" gate and ouputs the output on the wire term2
and u8 (Q, Ainv, term2); // using wires Ainv and term2 as inputs to an "and" gate and ouputs the output on the wire Q




endmodule