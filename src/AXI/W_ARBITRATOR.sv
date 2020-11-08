//================================================
// Auther:      Xu Yan-Ting (Yantinger)            
// Filename:    W_ARBITRATOR.sv                            
// Description: W_ARBITRATOR  module               
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

module W_ARBITRATOR(
    /*Since we don't need to write data to IM, */
    /*There is no AW signal for master 0*/
    /*Master 1 input port*/
    //WRITE DATA
	input [`AXI_DATA_BITS-1:0] WDATA_M1,
	input [`AXI_STRB_BITS-1:0] WSTRB_M1,
	input WLAST_M1,
	input WVALID_M1,
    input AW_IDLE,
    output logic [`AXI_DATA_BITS-1:0] WDATA,
	output logic [`AXI_STRB_BITS-1:0] WSTRB,
	output logic WLAST,
	output logic WVALID,
    output logic W_IDLE
);

// enum { IDLE, GRANT_1 } current_state, next_state;

//     always@(posedge clk, posedge rst)
//     begin
//         if(rst) current_state <= IDLE;
//         else    current_state <= next_state;
//     end

//     always@(*)
//     begin
//         case (current_state)
//             IDLE: next_state = (AW_IDLE)? 
//             GRANT_1:
//             begin
                
//             end
//         endcase
//     end

    always@(*)
    begin
        if(AW_IDLE)
        begin
            WDATA = `AXI_DATA_BITS'd0;
            WSTRB = `AXI_STRB_BITS'd0;
            WLAST = 1'b0;
            WVALID = 1'b0;
	    W_IDLE = 1'b1;
        end
        else
        begin
            WDATA = WDATA_M1;
            WSTRB = WSTRB_M1;
            WLAST = WLAST_M1;
            WVALID = WVALID_M1;
	    W_IDLE = 1'b0;
        end
    end
endmodule
