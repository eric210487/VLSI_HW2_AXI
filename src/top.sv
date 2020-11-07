`include "../include/parameters.svh"
`include "cpu.sv"
`include "SRAM_wrapper.sv"
module top(
    input clk,
    input rst
);

logic i_cs, i_oe;
logic [3:0]i_web;
logic [13:0]i_address;
logic [`data_size-1:0]i_di;

logic d_cs, d_oe, d_oe_reg;
logic [3:0] d_web;
logic [13:0]d_address;
logic [`data_size-1:0]d_di;

logic [`data_size-1:0]i_do,d_do;


always_ff @(posedge clk, posedge rst) begin
    if (rst) d_oe_reg <= 1'b0;
    else d_oe_reg <= d_oe;
end

cpu cpu(
    .i_cs(i_cs),
    .i_oe(i_oe),
    .i_web(i_web),
    .i_address(i_address),
    .i_di(i_di),
    .d_cs(d_cs),
    .d_oe(d_oe),
    .d_web(d_web),
    .d_address(d_address),
    .d_di(d_di),
    .i_do(i_do),
    .d_do(d_do),
    .clk(clk),
    .rst(rst)
);
SRAM_wrapper IM1(
    .CK(clk),
    .CS(i_cs),
    .OE(i_oe),
    .WEB(i_web),
    .A(i_address),
    .DI(i_di),
    .DO(i_do)
);
SRAM_wrapper DM1(
    .CK(clk),
    .CS(d_cs),
    .OE(d_oe_reg),
    .WEB(d_web),
    .A(d_address),
    .DI(d_di),
    .DO(d_do)
);

endmodule