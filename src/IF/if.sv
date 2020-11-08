////`include "parameters.svh"
`include "if_id_reg.sv"
`include "pc_adder.sv"
`include "pc_mux.sv"
`include "pc_reg.sv"
module IF(
    output [13:0] pc_to_iram,      //address(pc)
    output [`pc_size-1:0] pc_if_id,

    input  if_id_write,
    input  pc_write,
    input  if_flush,
    input  [`pc_size-1:0] branch_pc,
    input  pcsrc,               //from branch comparison(1 for branch)

    input  clk,
    input  rst
);

logic [`pc_size-1:0] pc_mux_out,pc_add4,pc_reg_out,stallmux_out,if_id_pc;
assign pc_to_iram[13:0] = stallmux_out[15:2];
assign pc_if_id = if_id_pc;
pc_mux pc_mux(
    .out(pc_mux_out),
    .in0(pc_add4),
    .in1(branch_pc),
    .select(pcsrc)
);
pc_mux stallmux(
    .out(stallmux_out),
    .in0(if_id_pc),
    .in1(pc_reg_out),
    .select(if_id_write)
);
pc_reg pc_reg(
    .pc_out(pc_reg_out),
    .pc_in(pc_mux_out),
    .pc_origin(pc_reg_out),
    .w_en(pc_write),
    .clk(clk),
    .rst(rst)
);
pc_adder pc_adder(
    .pc_out(pc_add4),
    .pc_in(pc_reg_out)
);
if_id_reg if_id_reg(
    .pc_out(if_id_pc),
    .pc_in(pc_reg_out),
    .wen(if_id_write),
    .if_flush(if_flush),
    .clk(clk),
    .rst(rst)
);



endmodule