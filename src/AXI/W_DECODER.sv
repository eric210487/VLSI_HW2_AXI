//================================================
// Auther:      Xu Yan-Ting (Yantinger)            
// Filename:    W_DECODER.sv                            
// Description: W_DECODER  module               
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

module W_DECODER(
    input clk,
    input rst,
    input W_IDLE,
    input AW_LOCK,
    /*input from aw_arbitrator*/
    input AWVALID_in,
    /*input from aw_decoder*/
    input [1:0]slave_ID_in,
    input [`AXI_DATA_BITS-1:0] WDATA,
	input [`AXI_STRB_BITS-1:0] WSTRB,
	input WLAST,
	input WVALID,
    /* input from slave 0 */
    input WREADY_S0,
    /* input from slave 1 */
    input WREADY_S1,
    /* input from slave 2 */
    input WREADY_S2,
    /* output to Master0 */ //no need to cinsider about master 0 
    /* output to Master1 */
    output logic WREADY_M1,
    /* output to Slave0 */
    output logic [`AXI_DATA_BITS-1:0] WDATA_S0,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_S0,
	output logic WLAST_S0,
	output logic WVALID_S0,
    /* output to Slave1 */
	output logic [`AXI_DATA_BITS-1:0] WDATA_S1,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_S1,
	output logic WLAST_S1,
	output logic WVALID_S1,
    /* output to Slave2 */
	output logic WVALID_S2,
    output logic WREADY_AW_ARB
    );

    logic [1:0] slave_ID;

    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            slave_ID <= 2'd0;
        end
        else
        begin
            case (AWVALID_in)
                1'b1:
                    slave_ID <= slave_ID_in;
                default:
                    slave_ID <= slave_ID;

            endcase
        end
    end

    always@(*)
    begin
    if (W_IDLE) 
    begin
        WDATA_S0 = 32'd0;
        WSTRB_S0 = 4'd0;
        WLAST_S0 = 1'b0;
        WVALID_S0 = 1'b0;
        WDATA_S1 = 32'd0;
        WSTRB_S1 = 4'd0;
        WLAST_S1 = 1'b0;
        WVALID_S1 = 1'b0;
        WVALID_S2 = 1'b0;
    //always master 1
        WREADY_M1 = 1'b0;
        WREADY_AW_ARB = 1'b0;
    end
    else if(AW_LOCK)
    begin
    //slave 0 
        if(slave_ID == 2'd1)
        begin
            WDATA_S0 = WDATA;
            WSTRB_S0 = WSTRB;
            WLAST_S0 = WLAST;
            WVALID_S0 = WVALID;
            WDATA_S1 = 32'd0;
            WSTRB_S1 = 4'd0;
            WLAST_S1 = 1'b0;
            WVALID_S1 = 1'b0;
            WVALID_S2 = 1'b0;
        //always master 1
            WREADY_M1 = WREADY_S0;
            WREADY_AW_ARB = WREADY_S0;
        end
        else if(slave_ID == 2'd2)
        begin
            WDATA_S0 = 32'd0;
            WSTRB_S0 = 4'd0;
            WLAST_S0 = 1'b0;
            WVALID_S0 = 1'b0;
            WDATA_S1 = WDATA;
            WSTRB_S1 = WSTRB;
            WLAST_S1 = WLAST;
            WVALID_S1 = WVALID;
            WVALID_S2 = 1'b0;
        //always master 1
            WREADY_M1 = WREADY_S1;
            WREADY_AW_ARB = WREADY_S1;
        end
        else
        begin
            WDATA_S0 = 32'd0;
            WSTRB_S0 = 4'd0;
            WLAST_S0 = 1'b0;
            WVALID_S0 = 1'b0;
            WDATA_S1 = 32'd0;
            WSTRB_S1 = 4'd0;
            WLAST_S1 = 1'b0;
            WVALID_S1 = 1'b0;
            WVALID_S2 = WVALID;
            WREADY_M1 = WREADY_S2;
            WREADY_AW_ARB = WREADY_S2;
        end
    end
    else
    begin
    //slave 0 
        if(slave_ID_in == 2'd1)
        begin
            WDATA_S0 = WDATA;
            WSTRB_S0 = WSTRB;
            WLAST_S0 = WLAST;
            WVALID_S0 = WVALID;
            WDATA_S1 = 32'd0;
            WSTRB_S1 = 4'd0;
            WLAST_S1 = 1'b0;
            WVALID_S1 = 1'b0;
            WVALID_S2 = 1'b0;
        //always master 1
            WREADY_M1 = WREADY_S0;
            WREADY_AW_ARB = WREADY_S0;
        end
        else if(slave_ID_in == 2'd2)
        begin
            WDATA_S0 = 32'd0;
            WSTRB_S0 = 4'd0;
            WLAST_S0 = 1'b0;
            WVALID_S0 = 1'b0;
            WDATA_S1 = WDATA;
            WSTRB_S1 = WSTRB;
            WLAST_S1 = WLAST;
            WVALID_S1 = WVALID;
            WVALID_S2 = 1'b0;
        //always master 1
            WREADY_M1 = WREADY_S1;
            WREADY_AW_ARB = WREADY_S1;
        end
        else
        begin
            WDATA_S0 = 32'd0;
            WSTRB_S0 = 4'd0;
            WLAST_S0 = 1'b0;
            WVALID_S0 = 1'b0;
            WDATA_S1 = 32'd0;
            WSTRB_S1 = 4'd0;
            WLAST_S1 = 1'b0;
            WVALID_S1 = 1'b0;
            WVALID_S2 = WVALID;
            WREADY_M1 = WREADY_S2;
            WREADY_AW_ARB = WREADY_S2;
        end
    end
    end
endmodule
