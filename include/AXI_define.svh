`define AXI_ID_BITS 4
`define AXI_IDS_BITS 8
`define AXI_ADDR_BITS 32
`define AXI_LEN_BITS 4
`define AXI_SIZE_BITS 3
`define AXI_DATA_BITS 32
`define AXI_STRB_BITS 4

`define AXI_LEN_ONE 4'h0
`define AXI_SIZE_BYTE 3'b000
`define AXI_SIZE_HWORD 3'b001
`define AXI_SIZE_WORD 3'b010
`define AXI_BURST_INC 2'h1
`define AXI_STRB_WORD 4'b1111
`define AXI_STRB_HWORD 4'b0011
`define AXI_STRB_BYTE 4'b0001
`define AXI_RESP_OKAY 2'h0
`define AXI_RESP_SLVERR 2'h2
`define AXI_RESP_DECERR 2'h3

`define CPU_WRAPPER_RM0_INI  2'd0
`define CPU_WRAPPER_RM0_SEND 2'd1
`define CPU_WRAPPER_RM0_WAIT 2'd2

`define CPU_WRAPPER_RM1_INI    3'd0
`define CPU_WRAPPER_RM1_RSEND  3'd1
`define CPU_WRAPPER_RM1_RWAIT  3'd2
`define CPU_WRAPPER_RM1_WSEND  3'd3
`define CPU_WRAPPER_RM1_WWAIT  3'd4
`define CPU_WRAPPER_RM1_WREADY 3'd5

`define SRAM_WRAPPER_INI    3'd0
`define SRAM_WRAPPER_GETRA  3'd1
`define SRAM_WRAPPER_SEND   3'd2
`define SRAM_WRAPPER_GETWA  3'd3
`define SRAM_WRAPPER_GETW   3'd4
`define SRAM_WRAPPER_WRITE  3'd5

parameter data_size = 32;
parameter ins_size = 32;
parameter pc_size = 32;
parameter log_reg_num = 5;
parameter reg_num = 32;
parameter func_size = 4;