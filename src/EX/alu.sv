//finished
`include "parameters.svh"
module alu(
    output [data_size-1:0] zero,
    output logic[data_size-1:0] result,
    input  [data_size-1:0] data1,
    input  [data_size-1:0] data2,
    input  [func_size-1:0] func,
    input  ubranch
);

assign zero = 32'b0;
always_comb begin
    if(ubranch) result = data1+4;
    else begin
        case (func)
            `ALUADD :   result = data1+data2;
            `ALUSUB :   result = data1-data2;
            `ALUSLL :   result = data1<<data2[4:0];
            `ALUSLT :   result = ($signed(data1)<$signed(data2))?1:0;
            `ALUSLTU:   result = (data1<data2)?1:0;
            `ALUXOR :   result = data1^data2;
            `ALUSRL :   result = data1>>data2[4:0];
            `ALUSRA :   result = $signed(data1)>>>data2[4:0];
            `ALUOR  :   result = data1|data2;
            `ALUAND :   result = data1&data2;
            `ALULUI :   result = data2;
            default :   result = 0;
        endcase
    end
    
end

    
endmodule