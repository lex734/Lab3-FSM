module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out
);

    // Define states
    typedef enum {IDLE, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
    my_state current_state, next_state;

    always_comb
        case (current_state)
            IDLE: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = IDLE;
            default: next_state = IDLE;
        endcase

    //state registers
    always_ff @(posedge clk, posedge rst) 
        if (rst)        current_state <= IDLE;
        else if (en)    current_state <= next_state;


    logic [7:0] out;
    // output logic
    always_comb 
        case (current_state)
            S1: out = 8'b1;
            S2: out = 8'b11;
            S3: out = 8'b111;
            S4: out = 8'b1111;
            S5: out = 8'b11111;
            S6: out = 8'b111111;
            S7: out = 8'b1111111;
            S8: out = 8'b11111111;
            IDLE: out = 8'b0;
            default: out = 8'b0;
        endcase
    assign data_out = out;
endmodule
