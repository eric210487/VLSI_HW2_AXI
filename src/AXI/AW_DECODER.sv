//================================================
// Auther:      Xu Yan-Ting (Yantinger)            
// Filename:    AW_ARBITRATOR.sv                            
// Description: AW_DECODER  module               
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

module AW_DECODER(
    /*Since we don't need to write data to IM, */
    /*There is no AW signal for master 0*/
    input AW_IDLE,
    input AW_LOCK,
    /*Master 1 input port*/
    input [`AXI_ID_BITS-1:0] AWID,
	input [`AXI_ADDR_BITS-1:0] AWADDR,
	input [`AXI_LEN_BITS-1:0] AWLEN,
	input [`AXI_SIZE_BITS-1:0] AWSIZE,
	input [1:0] AWBURST,
    input AWVALID,
     /* input from slave 0 */
    input AWREADY_S0,
    /* input from slave 1 */
    input AWREADY_S1,
    /* input from slave 2 */
    input AWREADY_S2,
     /* output to Master0 */
    //output logic AWREADY_M0,
    /* output to Master1 */
    output logic AWREADY_M1,
    /* output to Slave0 */
    output logic [`AXI_IDS_BITS-1:0] AWID_S0,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_S0,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_S0,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_S0,
	output logic [1:0] AWBURST_S0,
    output logic AWVALID_S0,
    /* Output to Slave1 */ 
    /* Be careful of the number of bits  */
    output logic [`AXI_IDS_BITS-1:0] AWID_S1,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_S1,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_S1,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_S1,
	output logic [1:0] AWBURST_S1,
    output logic AWVALID_S1,
    /* Output to Slave2 (virtual slave) */
    output logic [`AXI_IDS_BITS-1:0] AWID_S2,
    output logic AWVALID_S2,
    /* For invalid address*/
    output logic[1:0] slave_ID,
    // AWREADY to AW arbitrator
    output logic AWREADY_to_AW_ARB
);

    always@(*)
    begin
    if(AW_IDLE || AW_LOCK)
    begin
        AWADDR_S0 = 32'd0;
        AWLEN_S0 = 4'd0;
        AWSIZE_S0 = 3'd0;
        AWBURST_S0 = 1'b0;
        AWVALID_S0 = 1'd0;
        AWID_S0 = 8'd0;
        AWADDR_S1 = 32'd0;
        AWLEN_S1 = 4'd0;
        AWSIZE_S1 = 3'd0;
        AWBURST_S1 = 2'd0;
        AWVALID_S1 = 1'b0;
        AWID_S1 = 8'd0;
        AWID_S2 = `AXI_IDS_BITS'd0;
        AWVALID_S2 = 1'b0;
    //always master 1
        //AWREADY_M0 = 1'b0;
        AWREADY_M1 = 1'b0;
        slave_ID = 2'd0;   
        AWREADY_to_AW_ARB = 1'b0;
    end
    else
    begin
        if(AWADDR <= 32'h0000ffff)
        begin  /* Slave 0 */
            AWADDR_S0 = AWADDR;
            AWLEN_S0 = AWLEN;
            AWSIZE_S0 = AWSIZE;
            AWBURST_S0 = AWBURST;
            AWVALID_S0 = AWVALID;
            AWID_S0 = {3'b000, 1'b1, AWID};
            AWADDR_S1 = 32'd0;
            AWLEN_S1 = 4'd0;
            AWSIZE_S1 = 3'd0;
            AWBURST_S1 = 2'd0;
            AWVALID_S1 = 1'b0;
            AWID_S1 = 8'd0;
            AWID_S2 = `AXI_IDS_BITS'd0;
            AWVALID_S2 = 1'b0;
        //always master 1
            //AWREADY_M0 = 1'b0;
            AWREADY_M1 = AWREADY_S0;
            slave_ID = 2'd1;   
            AWREADY_to_AW_ARB = AWREADY_S0;
            // Lock_AW = 1'b0;
        end
        else if(AWADDR <= 32'h0001ffff) //slave1
        begin
            AWADDR_S0 = 32'd0;
            AWLEN_S0 = 4'd0;
            AWSIZE_S0 = 3'd0;
            AWBURST_S0 = 2'd0;
            AWVALID_S0 = 1'b0;
            AWID_S0 = 8'd0;
            AWADDR_S1 = AWADDR;
            AWLEN_S1 = AWLEN;
            AWSIZE_S1 = AWSIZE;
            AWBURST_S1 = AWBURST;
            AWVALID_S1 = AWVALID;
            AWID_S1 = {3'b000, 1'b1, AWID};//MasterID = 1
            //always master 1
            //AWREADY_M0 = 1'b0;
            AWREADY_M1 = AWREADY_S1;
            slave_ID = 2'd2;
            AWREADY_to_AW_ARB = AWREADY_S1;
            AWID_S2 = `AXI_IDS_BITS'd0;
            AWVALID_S2 = 1'b0;

            // Lock_AW = 1'b0;
        end
        else
        begin
            AWADDR_S0 = 32'd0;
            AWLEN_S0 = 4'd0;
            AWSIZE_S0 = 3'd0;
            AWBURST_S0 = 2'd0;
            AWVALID_S0 = 1'b0;
            AWID_S0 = 8'd0;
            AWADDR_S1 = 32'd0;
            AWLEN_S1 = 4'd0;
            AWSIZE_S1 = 3'd0;
            AWBURST_S1 = 2'd0;
            AWVALID_S1 = 1'b0;
            AWID_S1 = 8'd0;
            //AWREADY_M0 = 1'b0;
            AWREADY_M1 = AWREADY_S2;
            slave_ID = 2'd0;
            // Lock_AW = 1'b1;
            AWID_S2 = {3'b000, 1'b1, AWID};
            AWVALID_S2 = AWVALID;
            AWREADY_to_AW_ARB = AWREADY_S2;
        end
    end
    end
endmodule
