module B_ARBITRATOR(
    input clk,
    input rst,
    /* Slave 0 */
    input [`AXI_IDS_BITS-1:0] BID_S0,
	input [1:0] BRESP_S0,
	input BVALID_S0,
    /* Slave 1 */
    input [`AXI_IDS_BITS-1:0] BID_S1,
	input [1:0] BRESP_S1,
    input BVALID_S1,
    /* Slave 2 */
    input [`AXI_IDS_BITS-1:0] BID_S2,
    input [1:0] BRESP_S2,
    input BVALID_S2,
    /* Master 1 */
    input BREADY_M1,
    /* Granted Output */
    output logic [1:0] SlaveID,
    output logic [`AXI_IDS_BITS-1:0] BID,
	output logic [1:0] BRESP,
	output logic BVALID
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
            if(BVALID_S2) next_state = GRANT_2;
            if(BVALID_S0 && !BVALID_S1)   next_state = GRANT_0;
            else if(!BVALID_S0 && BVALID_S1)  next_state = GRANT_1;
            else if(BVALID_S0 && BVALID_S1)   next_state = (last_grant)? GRANT_0:GRANT_1;
            else next_state = IDLE;
        end
        GRANT_0:
        begin
            if(BREADY_M1) next_state = IDLE;
            else    next_state = GRANT_0;
        end
        GRANT_1:
        begin
            if(BREADY_M1) next_state = IDLE;
            else    next_state = GRANT_1;
        end
        GRANT_2:
        begin
            if(BREADY_M1) next_state = IDLE;
            else    next_state = GRANT_2;
        end
    endcase
end

always@(*)
begin
    case (current_state)
        IDLE:
        begin
            SlaveID = 2'd3;
            BID = `AXI_ID_BITS'd0;
            BRESP = 2'd0;
            BVALID = 1'd0;
        end
        GRANT_0:
        begin
            SlaveID = 2'b0;
            BID = BID_S0;
            BRESP = BRESP_S0;
            BVALID = BVALID_S0;
        end
        GRANT_1:
        begin
            SlaveID = 2'd1;
            BID = BID_S1;
            BRESP = BRESP_S1;
            BVALID = BVALID_S1;
        end  
        GRANT_2:
        begin
            SlaveID = 2'd2;
            BID = BID_S2;
            BRESP = BRESP_S2;
            BVALID = BVALID_S2;
        end  
    endcase
end
endmodule
