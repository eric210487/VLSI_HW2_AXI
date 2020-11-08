module VIRTUALSLAVE(
    input clk,
    input rst,
    /* AR channel */
    input  [`AXI_IDS_BITS-1:0] ARID,
    input  ARVALID,
    output logic ARREADY,
    /* R channel */
    input  RREADY,
    output logic [`AXI_IDS_BITS-1:0] RID,
	output logic [1:0] RRESP,
    output logic RVALID,
    /* AW channel */
    input  [`AXI_IDS_BITS-1:0] AWID,
    input  AWVALID,
    output logic AWREADY,
    /* W channel  */
    input WVALID,
    output logic WREADY,
    /* B channel  */
    input BREADY,
    output logic [`AXI_IDS_BITS-1:0] BID,
    output logic [1:0] BRESP,
    output logic BVALID
);

    enum { IDLE , R_READ_ADDR, W_READ_ADDR, R_REPORT_ERROR, W_RECEIVE_DATA, W_REPORT_ERROR } current_state, next_state;

    logic [`AXI_IDS_BITS-1:0] ARID_reg;
    logic [`AXI_IDS_BITS-1:0] AWID_reg;

    always@(posedge clk, posedge rst)
    begin
        if(rst)
        begin 
            ARID_reg <= `AXI_IDS_BITS'd0;
            AWID_reg <= `AXI_IDS_BITS'd0;
        end
        else
        begin
            case (current_state)
                R_READ_ADDR:
                begin
                    ARID_reg <= ARID;
                    AWID_reg <= AWID_reg;
                end
                W_READ_ADDR:
                begin
                    ARID_reg <= ARID_reg;
                    AWID_reg <= AWID;
                end
                default:
                begin
                    ARID_reg <= ARID_reg;
                    AWID_reg <= AWID_reg;
                end
            endcase      
        end
    end

    always@(posedge clk, posedge rst)
    begin
        if(rst) current_state <= IDLE;
        else current_state <= next_state;
    end

    always@(*)
    begin
       case (current_state)
            IDLE:
            begin
                if(ARVALID) next_state = R_READ_ADDR;
                else if(AWVALID)    next_state = W_READ_ADDR;
                else    next_state = IDLE;
            end
            R_READ_ADDR:   next_state = (ARVALID)? R_REPORT_ERROR : R_READ_ADDR;
            W_READ_ADDR:   next_state = (AWVALID)? W_REPORT_ERROR : W_READ_ADDR;
            R_REPORT_ERROR: next_state = (RREADY)? IDLE : R_REPORT_ERROR;
            W_RECEIVE_DATA: next_state = (WVALID)? W_REPORT_ERROR : W_REPORT_ERROR;
            W_REPORT_ERROR: next_state = (BREADY)? IDLE : W_REPORT_ERROR;
       endcase 
    end

    always@(*)
    begin
        case (current_state)
            IDLE:
            begin
                ARREADY = 1'b0;
                RID = `AXI_IDS_BITS'd0;
                RRESP = 2'd0;
                RVALID = 1'b0;
                AWREADY = 1'b0;
                WREADY = 1'b0;
                BID = `AXI_IDS_BITS'd0;
                BRESP = 2'd0;
                BVALID = 1'b0;
            end
            R_READ_ADDR:
            begin
                ARREADY = 1'b1;
                RID = `AXI_IDS_BITS'd0;
                RRESP = 2'd0;
                RVALID = 1'b0;
                AWREADY = 1'b0;
                WREADY = 1'b0;
                BID = `AXI_IDS_BITS'd0;
                BRESP = 2'd0;
                BVALID = 1'b0;
            end
            W_READ_ADDR:
            begin
                ARREADY = 1'b0;
                RID = `AXI_IDS_BITS'd0;
                RRESP = 2'd0;
                RVALID = 1'b0;
                AWREADY = 1'b1;
                WREADY = 1'b0;
                BID = `AXI_IDS_BITS'd0;
                BRESP = 2'd0;
                BVALID = 1'b0;
            end
            R_REPORT_ERROR:
            begin
                ARREADY = 1'b0;
                RID = ARID_reg;
                RRESP = `AXI_RESP_DECERR;
                RVALID = 1'b1;
                AWREADY = 1'b0;
                WREADY = 1'b0;
                BID = `AXI_IDS_BITS'd0;
                BRESP = 2'd0;
                BVALID = 1'b0;
            end
            W_RECEIVE_DATA:
            begin
                ARREADY = 1'b0;
                RID = `AXI_IDS_BITS'd0;
                RRESP = 2'd0;
                RVALID = 1'b0;
                AWREADY = 1'b0;
                WREADY = 1'b1;
                BID = `AXI_IDS_BITS'd0;
                BRESP = 2'd0;
                BVALID = 1'b0;
            end
            W_REPORT_ERROR:
            begin
                ARREADY = 1'b0;
                RID = `AXI_IDS_BITS'd0;
                RRESP = 2'd0;
                RVALID = 1'b0;
                AWREADY = 1'b0;
                WREADY = 1'b0;
                BID = AWID_reg;
                BRESP = `AXI_RESP_DECERR;
                BVALID = 1'b1;
            end
        endcase
    end
endmodule
