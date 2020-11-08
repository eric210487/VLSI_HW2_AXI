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
module AR_DECODER(
    input AR_LOCK,
    input AR_IDLE,
    /* input from master */
    input [1:0] MasterID,  //For identifying which master owns the channel, 0 for master0, 1 for master1
    input [`AXI_ID_BITS-1:0] ARID,
	input [`AXI_ADDR_BITS-1:0] ARADDR,
	input [`AXI_LEN_BITS-1:0] ARLEN,
	input [`AXI_SIZE_BITS-1:0] ARSIZE,
	input [1:0] ARBURST,
    input ARVALID,
    /* input from slave 0 */
    input ARREADY_S0,
    /* input from slave 1 */
    input ARREADY_S1,
    /* input from slave 2 */
    input ARREADY_S2,
    /* output to Master0 */
    output logic ARREADY_M0,
    /* output to Master1 */
    output logic ARREADY_M1,
    /* output to Slave0 */
    output logic [`AXI_IDS_BITS-1:0] ARID_S0,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_S0,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_S0,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_S0,
	output logic [1:0] ARBURST_S0,
    output logic ARVALID_S0,
    /* Output to Slave1 */ 
    /* Be careful of the number of bits  */
    output logic [`AXI_IDS_BITS-1:0] ARID_S1,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_S1,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_S1,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_S1,
	output logic [1:0] ARBURST_S1,
    output logic ARVALID_S1,
    /* Output to Slave2 */ //virtual slave for invalid address
    output logic [`AXI_IDS_BITS-1:0] ARID_S2,
    output logic ARVALID_S2,
    /* For invalid address */
    //output logic INVALID_ADDR, 
    //output logic CULPRIT,
    /* Decoded Slave number */
    output logic [1:0] DEC_SLAVE_ID
    //output logic Lock_AR
);

    always@(*)
    begin
        if(AR_IDLE || AR_LOCK)
        begin  /* Slave 0 */
            ARADDR_S0 = 32'd0;
            ARLEN_S0 = 4'd0;
            ARSIZE_S0 = 3'd0;
            ARBURST_S0 = 2'd0;
            ARVALID_S0 = 1'b0;
            ARID_S0 = `AXI_IDS_BITS'd0;
            ARADDR_S1 = 32'd0;
            ARLEN_S1 = 4'd0;
            ARSIZE_S1 = 3'd0;
            ARBURST_S1 = 2'd0;
            ARVALID_S1 = 1'b0;
            ARID_S1 = `AXI_IDS_BITS'd0;
	    ARID_S2 = `AXI_IDS_BITS'd0;
	    ARVALID_S2 = 1'b0;
            ARREADY_M0 = 1'b0;
            ARREADY_M1 = 1'b0;
            DEC_SLAVE_ID = 2'd0;
        end
        else if(ARADDR <= 32'h0000ffff)
        begin  /* Slave 0 */
            ARADDR_S0 = ARADDR;
            ARLEN_S0 = ARLEN;
            ARSIZE_S0 = ARSIZE;
            ARBURST_S0 = ARBURST;
            ARVALID_S0 = ARVALID;
            ARID_S0 = {3'b000, MasterID, ARID};
            ARADDR_S1 = 32'd0;
            ARLEN_S1 = 4'd0;
            ARSIZE_S1 = 3'd0;
            ARBURST_S1 = 2'd0;
            ARVALID_S1 = 1'b0;
            ARID_S1 = `AXI_IDS_BITS'd0;
	    ARID_S2 = `AXI_IDS_BITS'd0;
	    ARVALID_S2 = 1'b0;
            case (MasterID)
                2'd0:
                begin
                    ARREADY_M0 = ARREADY_S0;
                    ARREADY_M1 = 1'b0;
                end
                2'd1:
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = ARREADY_S0;
                end
                2'd2:
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = 1'b0;
                end
            endcase
            //INVALID_ADDR = 1'b0;
            //CULPRIT = 1'b0;
            DEC_SLAVE_ID = 2'd0;
            //Lock_AR = 1'b0;
        end
        else if(ARADDR <= 32'h0001ffff) //slave1
        begin
            ARADDR_S0 = 32'd0;
            ARLEN_S0 = 4'd0;
            ARSIZE_S0 = 3'd0;
            ARBURST_S0 = 2'd0;
            ARVALID_S0 = 1'b0;
            ARID_S0 = 8'd0;
            ARADDR_S1 = ARADDR;
            ARLEN_S1 = ARLEN;
            ARSIZE_S1 = ARSIZE;
            ARBURST_S1 = ARBURST;
            ARVALID_S1 = ARVALID;
            ARID_S1 = {3'b000, MasterID, ARID};
	    ARID_S2 = `AXI_IDS_BITS'd0;
	    ARVALID_S2 = 1'b0;
            case (MasterID)
                2'd0:
                begin
                    ARREADY_M0 = ARREADY_S1;
                    ARREADY_M1 = 1'b0;
                end
                2'd1:
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = ARREADY_S1;
                end
                2'd2:  //AR channel idling
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = 1'b0;
                end
            endcase
            //INVALID_ADDR = 1'b0;
            //CULPRIT = 1'b0;
            DEC_SLAVE_ID = 2'd1;
            //Lock_AR = 1'b0;
        end
        else
        begin
            ARADDR_S0 = 32'd0;
            ARLEN_S0 = 4'd0;
            ARSIZE_S0 = 3'd0;
            ARBURST_S0 = 2'd0;
            ARVALID_S0 = 1'b0;
            ARID_S0 = 8'd0;
            ARADDR_S1 = 32'd0;
            ARLEN_S1 = 4'd0;
            ARSIZE_S1 = 3'd0;
            ARBURST_S1 = 2'd0;
            ARVALID_S1 = 1'b0;
            ARID_S1 = 8'd0;
            case (MasterID)
                2'd0:
                begin
                    ARREADY_M0 = ARREADY_S2;
                    ARREADY_M1 = 1'b0;
                end
                2'd1:
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = ARREADY_S2;
                end
                2'd2:  //AR channel idling
                begin
                    ARREADY_M0 = 1'b0;
                    ARREADY_M1 = 1'b0;
                end
            endcase
	        ARID_S2 = {3'b000, MasterID, ARID};
	        ARVALID_S2 = ARVALID;
            //INVALID_ADDR = 1'b1;
            //case (MasterID)
            //    1'b0: CULPRIT = 1'b0;
            //    1'b1: CULPRIT = 1'b1;
            //endcase
            DEC_SLAVE_ID = 2'd2;
            //Lock_AR = 1'b1;
        end
    end

endmodule
