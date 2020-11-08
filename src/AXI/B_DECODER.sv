// `define AXI_ID_BITS 4
// `define AXI_IDS_BITS 8
// `define AXI_ADDR_BITS 32
// `define AXI_LEN_BITS 4
// `define AXI_SIZE_BITS 3
// `define AXI_DATA_BITS 32
// `define AXI_STRB_BITS 4
// `define AXI_LEN_ONE 4'h0
// `define AXI_SIZE_BYTE 3'b000
// `define AXI_SIZE_HWORD 3'b001
// `define AXI_SIZE_WORD 3'b010
// `define AXI_BURST_INC 2'h1
// `define AXI_STRB_WORD 4'b1111
// `define AXI_STRB_HWORD 4'b0011
// `define AXI_STRB_BYTE 4'b0001
// `define AXI_RESP_OKAY 2'h0
// `define AXI_RESP_SLVERR 2'h2
// `define AXI_RESP_DECERR 2'h3

module B_DECODER(
    input clk,
    input rst,
    /* For invalid address*/
    // input [1:0] SlaveID_from_aw_de,
    // input [`AXI_ID_BITS-1:0] AWID_from_aw_de,
    /* ------------------ */
    input [1:0] SlaveID,
    input [`AXI_IDS_BITS-1:0] BID,
	input [1:0] BRESP,
    input BVALID,
    /* input from master 1 (m0 doesn't have BREADY)*/
    input BREADY_M1,
    /* output to slave 0, 1 */
    output logic BREADY_S0,
    output logic BREADY_S1,
    output logic BREADY_S2,
    /* output to master 0 */
    //master 0 doesn't have B_channel signals
    /* output to master 1 */
    output logic [`AXI_ID_BITS-1:0] BID_M1,
	output logic [1:0] BRESP_M1,
	output logic BVALID_M1
    //output logic Release_AW  //used to release ar channel after DECERR is received
);
    /* B_DECODER FSM */
    // NORMAL: Normally pass granted signal from arbitrator 
    // LOCK: Lock because a invalid address is received in AW decoder,
    //       and the bus has to send DECERR and wait for the master to receive
    // enum { 
    //     NORMAL, 
    //     LOCK    
    // } current_state, next_state;
    // logic [`AXI_ID_BITS-1:0] AWID_reg;

    /* Sequential for FSM */
    // always@(posedge clk, posedge rst)
    // begin
    //     if(rst)
	// begin
	//     AWID_reg <= `AXI_ID_BITS'd0;
	//     current_state <= NORMAL;
	// end
    //     else
	// begin
	//     current_state <= next_state;
	//     case (current_state)
	//     NORMAL:    AWID_reg <= AWID_from_aw_de;
	//     LOCK:    AWID_reg <= AWID_reg;
	//     endcase
	// end
    // end

    /* Combinatial for state */
    // always@(*)
    // begin
    //    case (current_state)
    //     NORMAL:
    //     begin
    //         if(!SlaveID_from_aw_de)  next_state = LOCK;
    //         else next_state = NORMAL;
    //     end
    //     LOCK:
    //     begin
    //         if(BREADY_M1)   next_state = NORMAL;
    //         else next_state = LOCK;
    //     end
    //    endcase 
    // end

    /* Combinatial for signals */
    always@(*)
    begin
        // case (current_state)
        //     NORMAL:
        //     begin
                case (SlaveID)
                    2'd0:
                    begin
                        BID_M1 = BID[3:0];
                        BRESP_M1 = BRESP;
                        BVALID_M1 = BVALID;
                        BREADY_S0 = BREADY_M1;
                        BREADY_S1 = 1'b0;
                        BREADY_S2 = 1'b0;
                    end
                    2'd1:
                    begin
                        BID_M1 = BID[3:0];
                        BRESP_M1 = BRESP;
                        BVALID_M1 = BVALID;
                        BREADY_S0 = 1'b0;
                        BREADY_S1 = BREADY_M1;
                        BREADY_S2 = 1'b0;
                    end
                    2'd2:
                    begin
                        BID_M1 = BID[3:0];
                        BRESP_M1 = BRESP;
                        BVALID_M1 = BVALID;
                        BREADY_S0 = 1'b0;
                        BREADY_S1 = 1'b0;
                        BREADY_S2 = BREADY_M1;
                    end
		    2'd3:
		    begin
                        BID_M1 = 4'd0;
                        BRESP_M1 = 2'd0;
                        BVALID_M1 = 1'b0;
                        BREADY_S0 = 1'b0;
                        BREADY_S1 = 1'b0;
                        BREADY_S2 = 1'b0;
                    end
                endcase
                // Release_AW = 1'b1;
            end
    //         LOCK:
    //         begin
    //             BID_M1 = AWID_from_aw_de;
    //             BRESP_M1 = `AXI_RESP_DECERR;
    //             BVALID_M1 = 1'b1;
    //             BREADY_S0 = 1'b0;
    //             BREADY_S1 = 1'b0;
    //             Release_AW = 1'b0;
    //         end
    //     endcase
    // end
endmodule
