module lfsr(
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [4:1] data_out
);

    logic [4:1] sreg;

always_ff @(posedge clk, posedge rst) 
    if (rst) 
        sreg <= {3'b0, 1'b1};
    else if (en)
        sreg <= {sreg[3:1], sreg[4] ^ sreg[3]};

assign data_out = sreg;
endmodule
