module cpu_wrapper(
    //connect with cpu(about M0 ISRAM)
    //input i_cs,                         //chip select
    input i_oe,                         //output enable
    input [3:0]i_web,                   //write enable
    input [13:0]i_address,              //address
    input logic[data_size-1:0]i_di,     //data_in
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

endmodule