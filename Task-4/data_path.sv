module data_path(
	input logic CLK,
	input logic en_low,
	input logic en_high,
	input logic RESET,
	input logic [3:0] DATA_IN,
	output logic [7:0] DATA_OUT
);
//logic CLK
logic [3:0] D;
logic logic_high;
reg [7:0] Q;
logic SYSTEM_RESET;

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[7] <= 0;
	end else if (!logic_high) begin
		Q[7] <= 1;
	end else if (en_high) begin
		Q[7] <= D[3];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[5] <= 0;
	end else if (!logic_high) begin
		Q[5] <= 1;
	end else if (en_high) begin
		Q[5] <= D[1];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[4] <= 0;
	end else if (!logic_high) begin
		Q[4] <= 1;
	end else if (en_high) begin
		Q[4] <= D[0];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[3] <= 0;
	end else if (!logic_high) begin
		Q[3] <= 1;
	end else if (en_low) begin
		Q[3] <= D[3];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[2] <= 0;
	end else if (!logic_high) begin
		Q[2] <= 1;
	end else if (en_low) begin
		Q[2] <= D[2];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[1] <= 0;
	end else if (!logic_high) begin
		Q[1] <= 1;
	end else if (en_low) begin
		Q[1] <= D[1];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[0] <= 0;
	end else if (!logic_high) begin
		Q[0] <= 1;
	end else if (en_low) begin
		Q[0] <= D[0];
	end
end

always_ff @(posedge CLK or negedge RESET or negedge logic_high) begin
	if (!RESET) begin
		Q[6] <= 0;
	end else if (!logic_high) begin
		Q[6] <= 1;
	end else if (en_high) begin
		Q[6] <= D[2];
	end
end

assign DATA_OUT = Q;
assign D = DATA_IN;
assign logic_high = 1'b1;

endmodule