module cpu_wrapper(
    //connect with cpu(about M0 ISRAM)
    //input i_cs,                         //chip select
    input i_oe,                         //output enable
    //input [3:0]i_web,                   //write enable
    input [13:0]i_address,              //address
    //input [data_size-1:0]i_di,     //data_in
    output [data_size-1:0]i_do,         //data_out
    //connect with AXI bus (about M0 ISRAM)
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

    //connect with cpu(about M1 DSRAM)
    input d_cs,
    input d_oe,
    input [3:0]d_web,
    input [13:0]d_address,
    input [data_size-1:0]d_di,
    output [data_size-1:0]d_do,
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
			`CPU_WRAPPER_RM0_INI: begin
				if(i_oe) begin
					M0_state <= `CPU_WRAPPER_RM0_SEND;
				end
				else begin
					M0_state <= `CPU_WRAPPER_RM0_INI;
				end
			end
			`CPU_WRAPPER_RM0_SEND: begin
				if(ARREADY_M0) begin
					M0_state <= `CPU_WRAPPER_RM0_WAIT;
				end
				else begin
					M0_state <= `CPU_WRAPPER_RM0_SEND;
				end
			end
			`CPU_WRAPPER_RM0_WAIT: begin
				if(RVALID_M0) begin
					M0_state <= `CPU_WRAPPER_RM0_INI;
				end
				else begin
					M0_state <= `CPU_WRAPPER_RM0_WAIT;
				end
			end
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
		end
		`CPU_WRAPPER_RM0_SEND: begin
			ARID_M0		= 
			ARADDR_M0	=
			ARLEN_M0	=
			ARSIZE_M0	=
			ARBURST_M0	=
			ARVALID_M0	=
			RREADY_M0	=
		end
		`CPU_WRAPPER_RM0_WAIT: begin
			ARID_M0		= 
			ARADDR_M0	=
			ARLEN_M0	=
			ARSIZE_M0	=
			ARBURST_M0	=
			ARVALID_M0	=
			RREADY_M0	=
		end
	endcase
end


//M1 channel
always_ff @(posedge clk, posedge rst) begin
	if(rst) begin
		M0_state <= `CPU_WRAPPER_RM1_INI;
	end
	else begin
		`CPU_WRAPPER_RM1_INI: begin
			if(d_oe) begin
				M1_state <= `CPU_WRAPPER_RM1_RSEND;
			end
			else if (d_web) begin //d_web need to be tune
				M1_state <= `CPU_WRAPPER_RM1_WSEND;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_INI;
			end
		end
		`CPU_WRAPPER_RM1_RSEND: begin
			if(ARREADY_M1) begin
				M1_state <= `CPU_WRAPPER_RM1_RWAIT;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_RSEND;
			end
		end
		`CPU_WRAPPER_RM1_RWAIT: begin
			if(RVALID_M1) begin
				M1_state <= `CPU_WRAPPER_RM1_INI;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_RWAIT;
			end
		end
		`CPU_WRAPPER_RM1_WSEND: begin
			if(AWREADY_M1) begin  
				M1_state <= `CPU_WRAPPER_RM1_WWAIT;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_WSEND;
			end
		end
		`CPU_WRAPPER_RM1_WWAIT: begin
			if(WREADY_M1) begin
				M1_state <= `CPU_WRAPPER_RM1_WREADY;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_WWAIT;
			end
		end
		`CPU_WRAPPER_RM1_WREADY: begin
			if(BVALID_M1) begin
				M1_state <= `CPU_WRAPPER_RM1_INI;
			end
			else begin
				M1_state <= `CPU_WRAPPER_RM1_WREADY;
			end
		end
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