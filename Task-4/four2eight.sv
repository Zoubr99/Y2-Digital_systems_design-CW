module four2eight(
    input logic CLK,
    input logic DATA_VALID,
    input logic RESET,
    input logic [3:0] DATA_IN,
    output logic OUTPUT_VALID,
    output logic EN_H,
    output logic EN_L,
    output logic [7:0] DATA_OUT
);

    data_path b2v_inst1 (
        .CLK(CLK),
        .RESET(RESET),
        .en_low(EN_L),
        .en_high(EN_H),
        .DATA_IN(DATA_IN),
        .DATA_OUT(DATA_OUT)
    );

    sequencer  b2v_inst21 (
        .RESET(RESET),
        .CLK(CLK),
        .valid(DATA_VALID),
        .en_high(EN_H),
        .en_low(EN_L),
        .op_valid(OUTPUT_VALID)
    );

endmodule