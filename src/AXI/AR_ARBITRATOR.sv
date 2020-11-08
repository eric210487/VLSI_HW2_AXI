
module AR_ARBITRATOR(
    input clk,
    input rst,
    input [1:0] DEC_SLAVE_ID, // decoded slave id from ar decoder
    input RREADY,  //from R_decoder
    input RVALID,  //from R_decoder
    // input Release, //from B_DECODER
    /*Master 0*/
    input [`AXI_ID_BITS-1:0] ARID_M0,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	input [`AXI_LEN_BITS-1:0] ARLEN_M0,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	input [1:0] ARBURST_M0,
	input ARVALID_M0,
    /*Master 1*/
    input [`AXI_ID_BITS-1:0] ARID_M1,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	input [`AXI_LEN_BITS-1:0] ARLEN_M1,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	input [1:0] ARBURST_M1,
    input ARVALID_M1,
    /* Slave 0 */
    input ARREADY_S0,
    /* Slave 1 */
    input ARREADY_S1,
    /* Slave 2, virtual slave for invalid address  */
    input ARREADY_S2,
    /*Granted Output*/
    output logic [1:0] MasterID,
    output logic [`AXI_ID_BITS-1:0] ARID,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR,
	output logic [`AXI_LEN_BITS-1:0] ARLEN,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE,
	output logic [1:0] ARBURST,
    output logic ARVALID,
    output logic AR_LOCK,
    output logic AR_IDLE
);

    enum { IDLE, GRANT_0, GRANT_1, LOCK } current_state, next_state;

    logic last_grant;

    /* Sequential for last_grant reg */
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            last_grant <= 1'b0;
        else
        begin
            case (current_state)
                IDLE:   last_grant <= last_grant;
                GRANT_0:    last_grant <= 1'b0;
                GRANT_1:    last_grant <= 1'b1;
                LOCK:   last_grant <= last_grant;
            endcase
        end
    end

    /* Sequential for FSM */
    always@(posedge clk, posedge rst)
    begin
        if(rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    /* Combinatial for state */
    always@(*)
    begin
        case (current_state)
            IDLE:
            begin
                if(ARVALID_M0 && !ARVALID_M1)   next_state = GRANT_0;
                else if(!ARVALID_M0 && ARVALID_M1)  next_state = GRANT_1;
                else if(ARVALID_M0 && ARVALID_M1)   next_state = (last_grant)? GRANT_0:GRANT_1;
                else next_state = IDLE;
            end
            GRANT_0:
            begin
                // if (Lock)   next_state = LOCK;
                // else
                // begin
                    case (DEC_SLAVE_ID)
                        2'd0:
                        begin
                            if(ARREADY_S0) next_state = LOCK;
                            else    next_state = GRANT_0;
                        end
                        2'd1:
                        begin
                            if(ARREADY_S1) next_state = LOCK;
                            else    next_state = GRANT_0;
                        end
                        2'd2:
                        begin
                            if(ARREADY_S2) next_state = LOCK;
                            else    next_state = GRANT_0;
                        end   
                    endcase
                // end
            end
            GRANT_1:
            begin
                // if (Lock)   next_state = LOCK;
                // else
                // begin
                    case (DEC_SLAVE_ID)
                        2'd0:
                        begin
                            if(ARREADY_S0) next_state = LOCK;
                            else    next_state = GRANT_1;
                        end
                        2'd1:
                        begin
                            if(ARREADY_S1) next_state = LOCK;
                            else    next_state = GRANT_1;
                        end
                        2'd2:
                        begin
                            if(ARREADY_S2) next_state = LOCK;
                            else    next_state = GRANT_1;
                        end
                    endcase
                // end
            end
            LOCK:
            begin
                if (RREADY && RVALID)    next_state = IDLE;
                else next_state = LOCK;
            end
        endcase
    end

    always@(*)
    begin
        case (current_state)
            IDLE:
            begin
                MasterID = 2'd2;
                ARID = `AXI_ID_BITS'd0;
                ARADDR = `AXI_ADDR_BITS'd0;
                ARLEN = `AXI_LEN_BITS'd0;
                ARSIZE = `AXI_SIZE_BITS'd0;
                ARBURST = 1'b0;
                ARVALID = 1'b0;
		AR_LOCK = 1'b0;
		AR_IDLE = 1'b1;
            end
            GRANT_0:
            begin
                MasterID = 1'b0;
                ARID = ARID_M0;
                ARADDR = ARADDR_M0;
                ARLEN = ARLEN_M0;
                ARSIZE = ARSIZE_M0;
                ARBURST = ARBURST_M0;
                ARVALID = ARVALID_M0;
		AR_LOCK = 1'b0;
		AR_IDLE = 1'b0;
            end
            GRANT_1:
            begin
                MasterID = 1'b1;
                ARID = ARID_M1;
                ARADDR = ARADDR_M1;
                ARLEN = ARLEN_M1;
                ARSIZE = ARSIZE_M1;
                ARBURST = ARBURST_M1;
                ARVALID = ARVALID_M1;
		AR_LOCK = 1'b0;
		AR_IDLE = 1'b0;
            end  
            LOCK:
            begin
                MasterID = 1'b0;
                ARID = `AXI_ID_BITS'd0;
                ARADDR = `AXI_ADDR_BITS'd0;
                ARLEN = `AXI_LEN_BITS'd0;
                ARSIZE = `AXI_SIZE_BITS'd0;
                ARBURST = 1'b0;
                ARVALID = 1'b0;
		AR_LOCK = 1'b1;
		AR_IDLE = 1'b0;
            end
        endcase
    end

endmodule
