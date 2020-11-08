module R_ARBITRATOR(
    input clk,
    input rst,
    input DEC_MASTER_ID, // from r_decoder
    /* Slave 0 */
    input [`AXI_IDS_BITS-1:0] RID_S0,
	input [`AXI_DATA_BITS-1:0] RDATA_S0,
	input [1:0] RRESP_S0,
	input RLAST_S0,
    input RVALID_S0,
    /* Slave 1 */
    input [`AXI_IDS_BITS-1:0] RID_S1,
	input [`AXI_DATA_BITS-1:0] RDATA_S1,
	input [1:0] RRESP_S1,
	input RLAST_S1,
    input RVALID_S1,
    /* Slave 2 (Virtual Slave for invalid address read) */
    input [`AXI_IDS_BITS-1:0] RID_S2,
	input [1:0] RRESP_S2,
    input RVALID_S2,
    /* Master 0 */
    input RREADY_M0,
    /* Master 1 */
    input RREADY_M1,
    /* Granted Output */
    output logic [`AXI_IDS_BITS-1:0] RID,
	output logic [`AXI_DATA_BITS-1:0] RDATA,
	output logic [1:0] RRESP,
	output logic RLAST,
    output logic RVALID,
    output logic [1:0] SlaveID
);
    enum { IDLE, GRANT_0, GRANT_1, GRANT_2} current_state, next_state;

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
            GRANT_2:    last_grant <= last_grant;  
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
            if(RVALID_S2) next_state = GRANT_2;  // Slave 2 has the highest priority
            else if(RVALID_S0 && !RVALID_S1)   next_state = GRANT_0;
            else if(!RVALID_S0 && RVALID_S1)  next_state = GRANT_1;
            else if(RVALID_S0 && RVALID_S1)   next_state = (last_grant)? GRANT_0:GRANT_1;
            else next_state = IDLE;
        end
        GRANT_0:
        begin
                case (DEC_MASTER_ID)
                    2'd0:
                    begin
                        if(RREADY_M0) next_state = IDLE;
                        else    next_state = GRANT_0;
                    end
                    2'd1:
                    begin
                        if(RREADY_M1) next_state = IDLE;
                        else    next_state = GRANT_0;
                    end
                endcase
        end
        GRANT_1:
        begin
                case (DEC_MASTER_ID)
                    1'd0:
                    begin
                        if(RREADY_M0) next_state = IDLE;
                        else    next_state = GRANT_1;
                    end
                    1'd1:
                    begin
                        if(RREADY_M1) next_state = IDLE;
                        else    next_state = GRANT_1;
                    end
                endcase

        end
        GRANT_2:
        begin
            case (DEC_MASTER_ID)
                1'd0:
                begin
                    if(RREADY_M0) next_state = IDLE;
                    else    next_state = GRANT_2;
                end
                1'd1:
                begin
                    if(RREADY_M1) next_state = IDLE;
                    else    next_state = GRANT_2;
                end
            endcase
        end
    endcase
end

always@(*)
begin
    case (current_state)
        IDLE:
        begin
            RID = `AXI_IDS_BITS'd0;
            RDATA = `AXI_DATA_BITS'd0;
            RRESP = 2'd0;
            RLAST = 1'd0;
            RVALID = 1'd0;
            SlaveID = 2'd3;
        end
        GRANT_0:
        begin
            RID = RID_S0;
            RDATA = RDATA_S0;
            RRESP = RRESP_S0;
            RLAST = RLAST_S0;
            RVALID = RVALID_S0;
            SlaveID = 2'd0;
        end
        GRANT_1:
        begin
            RID = RID_S1;
            RDATA = RDATA_S1;
            RRESP = RRESP_S1;
            RLAST = RLAST_S1;
            RVALID = RVALID_S1;
            SlaveID = 2'd1;
        end
        GRANT_2:
        begin
            RID = RID_S2;
            RDATA = `AXI_DATA_BITS'd0;
            RRESP = RRESP_S2;
            RLAST = 1'b1;
            RVALID = RVALID_S2;
            SlaveID = 2'd2;
        end
    endcase
end
endmodule
