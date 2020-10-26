module cpu_wrapper(
    //READ ADDRESS0
	output [`AXI_ID_BITS-1:0] ARID_M0,          //don't need out of order (give zero?)
	output [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	output [`AXI_LEN_BITS-1:0] ARLEN_M0,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	output [1:0] ARBURST_M0,
	output ARVALID_M0,
	input ARREADY_M0,
    //READ DATA0
	input [`AXI_ID_BITS-1:0] RID_M0,
	input [`AXI_DATA_BITS-1:0] RDATA_M0,
	input [1:0] RRESP_M0,
	input RLAST_M0,
	input RVALID_M0,
	output RREADY_M0,

    //connect with AXI bus (about M1 DSRAM)
    //WRITE ADDRESS
	output [`AXI_ID_BITS-1:0] AWID_M1,
	output [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	output [`AXI_LEN_BITS-1:0] AWLEN_M1,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	output [1:0] AWBURST_M1,
	output AWVALID_M1,
	input AWREADY_M1,
    //WRITE DATA
	output [`AXI_DATA_BITS-1:0] WDATA_M1,
	output [`AXI_STRB_BITS-1:0] WSTRB_M1,
	output WLAST_M1,
	output WVALID_M1,
	input WREADY_M1,
    //WRITE RESPONSE
	input [`AXI_ID_BITS-1:0] BID_M1,
	input [1:0] BRESP_M1,
	input BVALID_M1,
	output BREADY_M1,
    //READ ADDRESS1
	output [`AXI_ID_BITS-1:0] ARID_M1,
	output [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	output [`AXI_LEN_BITS-1:0] ARLEN_M1,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	output [1:0] ARBURST_M1,
	output ARVALID_M1,
	input ARREADY_M1,
    //READ DATA1
	input [`AXI_ID_BITS-1:0] RID_M1,
	input [`AXI_DATA_BITS-1:0] RDATA_M1,
	input [1:0] RRESP_M1,
	input RLAST_M1,
	input RVALID_M1,
	output RREADY_M1,

    //wrapper need clk?
	input clk,
	input rst
);


logic [1:0]M0_state;
logic [2:0]M1_state;

//M0 channel
always_ff @(posedge clk, posedge rst) begin
	if(rst) begin
		M0_state <= `CPU_WRAPPER_RM0_INI;
	end
	else begin
		case (M0_state)
			`CPU_WRAPPER_RM0_INI:	M0_state <= (i_oe)?`CPU_WRAPPER_RM0_SEND:`CPU_WRAPPER_RM0_INI;
			`CPU_WRAPPER_RM0_SEND:	M0_state <= (ARREADY_M0)?`CPU_WRAPPER_RM0_WAIT:`CPU_WRAPPER_RM0_SEND;
			`CPU_WRAPPER_RM0_WAIT:	M0_state <= (RVALID_M0)?`CPU_WRAPPER_RM0_INI:`CPU_WRAPPER_RM0_WAIT;
		endcase
	end
end
always_comb begin
	case (M0_state)
		`CPU_WRAPPER_RM0_INI: begin
			ARID_M0		= 
			ARADDR_M0	=
			ARLEN_M0	=
			ARSIZE_M0	=
			ARBURST_M0	=
			ARVALID_M0	=
			RREADY_M0	=
			i_do		=
		end
		`CPU_WRAPPER_RM0_SEND: begin
			ARID_M0		= 
			ARADDR_M0	=
			ARLEN_M0	=
			ARSIZE_M0	=
			ARBURST_M0	=
			ARVALID_M0	=
			RREADY_M0	=
			i_do		=
		end
		`CPU_WRAPPER_RM0_WAIT: begin
			ARID_M0		= 
			ARADDR_M0	=
			ARLEN_M0	=
			ARSIZE_M0	=
			ARBURST_M0	=
			ARVALID_M0	=
			RREADY_M0	=
			i_do		=
		end
	endcase
end


//M1 channel
always_ff @(posedge clk, posedge rst) begin
	if(rst) begin
		M0_state <= `CPU_WRAPPER_RM1_INI;
	end
	else begin
		`CPU_WRAPPER_RM1_INI: 	M1_state <= (d_oe)?`CPU_WRAPPER_RM1_RSEND:((d_web)?`CPU_WRAPPER_RM1_WSEND:`CPU_WRAPPER_RM1_INI);
		`CPU_WRAPPER_RM1_RSEND: M1_state <= (ARREADY_M1)?`CPU_WRAPPER_RM1_RWAIT:`CPU_WRAPPER_RM1_RSEND;
		`CPU_WRAPPER_RM1_RWAIT: M1_state <= (RVALID_M1)?`CPU_WRAPPER_RM1_INI:`CPU_WRAPPER_RM1_RWAIT;
		`CPU_WRAPPER_RM1_WSEND: M1_state <= (AWREADY_M1)?`CPU_WRAPPER_RM1_WWAIT:`CPU_WRAPPER_RM1_WSEND;
		`CPU_WRAPPER_RM1_WWAIT: M1_state <= (WREADY_M1)?`CPU_WRAPPER_RM1_WREADY:`CPU_WRAPPER_RM1_WWAIT;
		`CPU_WRAPPER_RM1_WREADY:M1_state <= (BVALID_M1)?`CPU_WRAPPER_RM1_INI:`CPU_WRAPPER_RM1_WREADY;
	end
end
always_comb begin
	case (M1_state)
		`CPU_WRAPPER_RM1_INI: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=

		end
		`CPU_WRAPPER_RM1_RSEND: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=
		end
		`CPU_WRAPPER_RM1_RWAIT: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=
		end
		`CPU_WRAPPER_RM1_WSEND: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=
		end
		`CPU_WRAPPER_RM1_WWAIT: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=
		end
		`CPU_WRAPPER_RM1_WREADY: begin
			//Write address
			AWID_M1		=
			AWADDR_M1	=
			AWLEN_M1	=
			AWSIZE_M1	=
			AWBURST_M1	=
			AWVALID_M1	=
			//Write data
			WDATA_M1	=
			WSTRB_M1	=
			WLAST_M1	=
			WVALID_M1	=
			//WRITE RESPONSE
			BREADY_M1	=
			//READ ADDRESS1
			ARID_M1		= 
			ARADDR_M1	=
			ARLEN_M1	=
			ARSIZE_M1	=
			ARBURST_M1	=
			ARVALID_M1	=
			//READ DATA1
			RREADY_M1	=
		end
	endcase
end


endmodule