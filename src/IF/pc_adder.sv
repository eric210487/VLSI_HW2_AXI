//finished
////`include "parameters.svh"
module pc_adder(
    output  [`pc_size-1:0] pc_out,
    input   [`pc_size-1:0] pc_in
);
assign pc_out = pc_in + 4;
endmodule