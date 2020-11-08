//================================================
// Auther:      Xu Yan-Ting (Yantinger)            
// Filename:    AW_ARBITRATOR.sv                            
// Description: AW_ARBITRATOR  module               
// Version:     1.0 
//================================================
/*
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
*/

module AW_ARBITRATOR(
    /*Since we don't need to write data to IM, */
    /*There is no AW signal for master 0*/
    /*Master 1 input port*/
    // input Release,
    input clk,
    input rst,
    input [`AXI_ID_BITS-1:0] AWID_M1,
    input [`AXI_ADDR_BITS-1:0] AWADDR_M1,
    input [`AXI_LEN_BITS-1:0] AWLEN_M1,
    input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
    input [1:0] AWBURST_M1,
	input AWVALID_M1,
    input AWREADY, //from aw_decoder
    /* input from W Decoder to see if the transaction is finished */
    input WVALID,
    input WREADY,
    output logic [`AXI_ID_BITS-1:0] AWID,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR,
	output logic [`AXI_LEN_BITS-1:0] AWLEN,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE,
	output logic [1:0] AWBURST,
    output logic AWVALID,
    output logic AW_IDLE,
    output logic AW_LOCK
);

    enum { IDLE, GRANT_1, LOCK } current_state, next_state;
    
    always@(posedge clk, posedge rst)
    begin
        if(rst) current_state <= IDLE;
        else    current_state <= next_state;
    end

    logic [`AXI_ADDR_BITS-1:0] AWADDR_reg;
    always@(posedge clk, posedge rst)
    begin
        if(rst) AWADDR_reg <= `AXI_ADDR_BITS'd0;
        else
        begin
            case (current_state)
		IDLE:	AWADDR_reg <= AWADDR_reg;
                GRANT_1: AWADDR_reg <= AWADDR_M1;
                LOCK: AWADDR_reg <= AWADDR_reg;
            endcase
        end
    end

    always@(*)
    begin
        case (current_state)
            IDLE:       next_state = (AWVALID_M1)? GRANT_1:IDLE;
            GRANT_1:    next_state = (AWREADY)? LOCK:GRANT_1;
            LOCK:       next_state = (WVALID && WREADY)? IDLE:LOCK;
        endcase
    end

    always@(*)
    begin
        case (current_state)
            IDLE:
            begin
                AWID = `AXI_ID_BITS'd0;
                AWADDR = AWADDR_reg;
                AWLEN = `AXI_LEN_BITS'd0;
                AWSIZE = `AXI_SIZE_BITS'd0;
                AWBURST = 1'd0;
                AWVALID = 1'd0;
                AW_IDLE = 1'b1;
                AW_LOCK = 1'b0;
            end
            GRANT_1:
            begin
                AWID = AWID_M1;
                AWADDR = AWADDR_M1;
                AWLEN = AWLEN_M1;
                AWSIZE = AWSIZE_M1;
                AWBURST = AWBURST_M1;
                AWVALID = AWVALID_M1; 
                AW_IDLE = 1'b0;
                AW_LOCK = 1'b0;
            end
            LOCK:
            begin
                AWID = `AXI_ID_BITS'd0;
                AWADDR = AWADDR_reg;
                AWLEN = `AXI_LEN_BITS'd0;
                AWSIZE = `AXI_SIZE_BITS'd0;
                AWBURST = 1'd0;
                AWVALID = 1'd0;  
                AW_IDLE = 1'b0;
                AW_LOCK = 1'b1;
            end
        endcase
    end
endmodule
