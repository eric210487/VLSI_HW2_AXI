//finished
////`include "parameters.svh"
module if_id_reg(
    output  logic[`pc_size-1:0]  pc_out,
    input   [`pc_size-1:0]   pc_in,
    input   wen,
    input   if_flush,
    input   clk,
    input   rst
);

always@(posedge clk or posedge rst)begin
    if(rst) begin
        pc_out  <= 1'b0;
    end
    else if(if_flush) begin
        pc_out  <= 1'b0;
    end
    else if(wen) begin
        pc_out  <= pc_in;
    end
    else begin
        pc_out  <= pc_out;
    end

end


endmodule