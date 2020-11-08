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
module R_DECODER(
    input clk,
    input rst,
    /* For Invalid address (from AR_DECODER) */
    // input INVALID_ADDR, 
    // input CULPRIT,
    /* input from R_ARBIRATOR */
    input [1:0] SlaveID,
    input [`AXI_IDS_BITS-1:0] RID,
	input [`AXI_DATA_BITS-1:0] RDATA,
	input [1:0] RRESP,
	input RLAST,
    input RVALID,
    /* input from master 0, 1 */
    input RREADY_M0,
    input RREADY_M1,
    /* output to slave 0, 1 */
    output logic RREADY_S0,
    output logic RREADY_S1,
    output logic RREADY_S2, //virtual slave for invalid address read
    /* output to master 0 */
    output logic [`AXI_ID_BITS-1:0] RID_M0,
	output logic [`AXI_DATA_BITS-1:0] RDATA_M0,
	output logic [1:0] RRESP_M0,
	output logic RLAST_M0,
	output logic RVALID_M0,
    /* output to master 1 */
    output logic [`AXI_ID_BITS-1:0] RID_M1,
	output logic [`AXI_DATA_BITS-1:0] RDATA_M1,
	output logic [1:0] RRESP_M1,
	output logic RLAST_M1,
    output logic RVALID_M1,
    /* Decoded master */
    output logic DEC_MASTER_ID,
    output logic RREADY_to_AR_ARB,
    output logic RVALID_to_AR_ARB
);

    assign RVALID_to_AR_ARB = RVALID;
    /* Combinatial for signals */
    always@(*)
    begin
                case (RID[4])
                    1'b0:  //Master 0
                    begin
                        RREADY_to_AR_ARB = RREADY_M0;
                        RID_M0 = RID;
                        RDATA_M0 = RDATA;
                        RRESP_M0 = RRESP;
                        RLAST_M0 = RLAST;
                        RVALID_M0 = RVALID;
			            RID_M1 = 0;
                        RDATA_M1 = 0;
                        RRESP_M1 = 0;
                        RLAST_M1 = 0;
                        RVALID_M1 = 0;
                        DEC_MASTER_ID = 1'b0;
                        case(SlaveID)
                            2'd0: 
                            begin 
                                RREADY_S0 = RREADY_M0;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = 1'b0;
                                // Release_AR = 1'b1;
                            end
                            2'd1:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = RREADY_M0;
                                RREADY_S2 = 1'b0;
                                // Release_AR = 1'b1;
                            end
                            2'd2:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = RREADY_M0;
                                // Release_AR = 1'b0;
                            end
                            2'd3:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = 1'b0;
                            end
                        endcase
                    end
                    1'b1:  //Master 1
                    begin
                        RREADY_to_AR_ARB = RREADY_M1;
                        RID_M0 = 0;
                        RDATA_M0 = 0;
                        RRESP_M0 = 0;
                        RLAST_M0 = 0;
                        RVALID_M0 = 0;
                        RID_M1 = RID;
                        RDATA_M1 = RDATA;
                        RRESP_M1 = RRESP;
                        RLAST_M1 = RLAST;
                        RVALID_M1 = RVALID;
                        DEC_MASTER_ID = 1'b1;
                        case(SlaveID)
                            2'd0: 
                            begin 
                                RREADY_S0 = RREADY_M1;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = 1'b0;
                                // Release_AR = 1'b1;
                            end
                            2'd1:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = RREADY_M1;
                                RREADY_S2 = 1'b0;
                                // Release_AR = 1'b1;
                            end
                            2'd2:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = RREADY_M1;
                                // Release_AR = 1'b0
                            end
                            2'd3:
                            begin
                                RREADY_S0 = 1'b0;
                                RREADY_S1 = 1'b0;
                                RREADY_S2 = 1'b0;
                            end
                        endcase
                    end
                endcase
                // Release_AR = 1'b1;
            end
            // LOCK:
            // begin
            //     case (CULPRIT)
            //         1'b0:
            //         begin
            //             RID_M0 = `AXI_ID_BITS'd0;
            //             RDATA_M0 = `AXI_DATA_BITS'd0;
            //             RRESP_M0 = `AXI_RESP_DECERR;
            //             RLAST_M0 = 1'b0;
            //             RVALID_M0 = 1'b1;
			//             RID_M1 = `AXI_ID_BITS'd0;
            //             RDATA_M1 = `AXI_DATA_BITS'd0;
            //             RRESP_M1 = 0;
            //             RLAST_M1 = 1'b0;
            //             RVALID_M1 = 1'b0;
            //             RREADY_S0 = 1'b0;
            //             RREADY_S1 = 1'b0;
            //             DEC_MASTER_ID = 1'b0;
            //         end
            //         1'b1:
            //         begin
            //             RID_M0 = `AXI_ID_BITS'd0;
            //             RDATA_M0 = `AXI_DATA_BITS'd0;
            //             RRESP_M0 = 0;
            //             RLAST_M0 = 1'b0;
            //             RVALID_M0 = 1'b0;
            //             RID_M1 = `AXI_ID_BITS'd0;
            //             RDATA_M1 = `AXI_DATA_BITS'd0;
            //             RRESP_M1 = `AXI_RESP_DECERR;
            //             RLAST_M1 = 1'b0;
            //             RVALID_M1 = 1'b1;
            //             RREADY_S0 = 1'b0;
            //             RREADY_S1 = 1'b0;
            //             DEC_MASTER_ID = 1'b1;
            //         end
            //     endcase
            //     Release_AR = 1'b0;
            // end
        //endcase
    //end
endmodule
