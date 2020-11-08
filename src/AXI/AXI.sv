//================================================
// Auther:      Chang Wan-Yun (Claire)            
// Filename:    AXI.sv                            
// Description: Top module of AXI                  
// Version:     1.0 
//================================================
`include "../../include/AXI_define.svh"
`include "AXI/AR_ARBITRATOR.sv"
`include "AXI/AW_ARBITRATOR.sv"
`include "AXI/W_ARBITRATOR.sv"
`include "AXI/R_ARBITRATOR.sv"
`include "AXI/B_ARBITRATOR.sv"
`include "AXI/AR_DECODER.sv"
`include "AXI/AW_DECODER.sv"
`include "AXI/W_DECODER.sv"
`include "AXI/R_DECODER.sv"
`include "AXI/B_DECODER.sv"
`include "AXI/VIRTUALSLAVE.sv"

module AXI(

	input ACLK,
	input ARESETn,

	//SLAVE INTERFACE FOR MASTERS
	//WRITE ADDRESS
	input [`AXI_ID_BITS-1:0] AWID_M1,
	input [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	input [`AXI_LEN_BITS-1:0] AWLEN_M1,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	input [1:0] AWBURST_M1,
	input AWVALID_M1,
	output AWREADY_M1,
	//WRITE DATA
	input [`AXI_DATA_BITS-1:0] WDATA_M1,
	input [`AXI_STRB_BITS-1:0] WSTRB_M1,
	input WLAST_M1,
	input WVALID_M1,
	output WREADY_M1,
	//WRITE RESPONSE
	output [`AXI_ID_BITS-1:0] BID_M1,
	output [1:0] BRESP_M1,
	output BVALID_M1,
	input BREADY_M1,

	//READ ADDRESS0
	input [`AXI_ID_BITS-1:0] ARID_M0,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	input [`AXI_LEN_BITS-1:0] ARLEN_M0,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	input [1:0] ARBURST_M0,
	input ARVALID_M0,
	output ARREADY_M0,
	//READ DATA0
	output [`AXI_ID_BITS-1:0] RID_M0,
	output [`AXI_DATA_BITS-1:0] RDATA_M0,
	output [1:0] RRESP_M0,
	output RLAST_M0,
	output RVALID_M0,
	input RREADY_M0,
	//READ ADDRESS1
	input [`AXI_ID_BITS-1:0] ARID_M1,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	input [`AXI_LEN_BITS-1:0] ARLEN_M1,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	input [1:0] ARBURST_M1,
	input ARVALID_M1,
	output ARREADY_M1,
	//READ DATA1
	output [`AXI_ID_BITS-1:0] RID_M1,
	output [`AXI_DATA_BITS-1:0] RDATA_M1,
	output [1:0] RRESP_M1,
	output RLAST_M1,
	output RVALID_M1,
	input RREADY_M1,

	//MASTER INTERFACE FOR SLAVES
	//WRITE ADDRESS0
	output [`AXI_IDS_BITS-1:0] AWID_S0,
	output [`AXI_ADDR_BITS-1:0] AWADDR_S0,
	output [`AXI_LEN_BITS-1:0] AWLEN_S0,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_S0,
	output [1:0] AWBURST_S0,
	output AWVALID_S0,
	input AWREADY_S0,
	//WRITE DATA0
	output [`AXI_DATA_BITS-1:0] WDATA_S0,
	output [`AXI_STRB_BITS-1:0] WSTRB_S0,
	output WLAST_S0,
	output WVALID_S0,
	input WREADY_S0,
	//WRITE RESPONSE0
	input [`AXI_IDS_BITS-1:0] BID_S0,
	input [1:0] BRESP_S0,
	input BVALID_S0,
	output BREADY_S0,
	
	//WRITE ADDRESS1
	output [`AXI_IDS_BITS-1:0] AWID_S1,
	output [`AXI_ADDR_BITS-1:0] AWADDR_S1,
	output [`AXI_LEN_BITS-1:0] AWLEN_S1,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_S1,
	output [1:0] AWBURST_S1,
	output AWVALID_S1,
	input AWREADY_S1,
	//WRITE DATA1
	output [`AXI_DATA_BITS-1:0] WDATA_S1,
	output [`AXI_STRB_BITS-1:0] WSTRB_S1,
	output WLAST_S1,
	output WVALID_S1,
	input WREADY_S1,
	//WRITE RESPONSE1
	input [`AXI_IDS_BITS-1:0] BID_S1,
	input [1:0] BRESP_S1,
	input BVALID_S1,
	output BREADY_S1,
	
	//READ ADDRESS0
	output [`AXI_IDS_BITS-1:0] ARID_S0,
	output [`AXI_ADDR_BITS-1:0] ARADDR_S0,
	output [`AXI_LEN_BITS-1:0] ARLEN_S0,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_S0,
	output [1:0] ARBURST_S0,
	output ARVALID_S0,
	input ARREADY_S0,
	//READ DATA0
	input [`AXI_IDS_BITS-1:0] RID_S0,
	input [`AXI_DATA_BITS-1:0] RDATA_S0,
	input [1:0] RRESP_S0,
	input RLAST_S0,
	input RVALID_S0,
	output RREADY_S0,
	//READ ADDRESS1
	output [`AXI_IDS_BITS-1:0] ARID_S1,
	output [`AXI_ADDR_BITS-1:0] ARADDR_S1,
	output [`AXI_LEN_BITS-1:0] ARLEN_S1,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_S1,
	output [1:0] ARBURST_S1,
	output ARVALID_S1,
	input ARREADY_S1,
	//READ DATA1
	input [`AXI_IDS_BITS-1:0] RID_S1,
	input [`AXI_DATA_BITS-1:0] RDATA_S1,
	input [1:0] RRESP_S1,
	input RLAST_S1,
	input RVALID_S1,
	output RREADY_S1
	
);

	wire rst;
	assign rst = ~ARESETn;

//AR_ARBITRATOR output ports

	wire [1:0] ar_arb_MasterID_out;
    wire [`AXI_ID_BITS-1:0] ar_arb_ARID_out;
	wire [`AXI_ADDR_BITS-1:0] ar_arb_ARADDR_out;
	wire [`AXI_LEN_BITS-1:0] ar_arb_ARLEN_out;
	wire[`AXI_SIZE_BITS-1:0] ar_arb_ARSIZE_out;
	wire [1:0] ar_arb_ARBURST_out;
	wire ar_arb_ARVALID_out;
	wire ar_arb_AR_LOCK_out;
	wire ar_arb_AR_IDLE_out;
	
//AR_DECODER
	wire ar_de_ARREADY_M0_out;
    wire ar_de_ARREADY_M1_out;
	wire [`AXI_IDS_BITS-1:0] ar_de_ARID_S0_out;
	wire [`AXI_ADDR_BITS-1:0] ar_de_ARADDR_S0_out;
	wire [`AXI_LEN_BITS-1:0] ar_de_ARLEN_S0_out;
	wire [`AXI_SIZE_BITS-1:0] ar_de_ARSIZE_S0_out;
	wire [1:0] ar_de_ARBURST_S0_out;
    wire ar_de_ARVALID_S0_out;
    /* Output to Slave1 */ 
    /* Be careful of the number of bits  */
    wire [`AXI_IDS_BITS-1:0] ar_de_ARID_S1_out;
	wire [`AXI_ADDR_BITS-1:0] ar_de_ARADDR_S1_out;
	wire [`AXI_LEN_BITS-1:0] ar_de_ARLEN_S1_out;
	wire [`AXI_SIZE_BITS-1:0] ar_de_ARSIZE_S1_out;
	wire [1:0] ar_de_ARBURST_S1_out;
	wire ar_de_ARVALID_S1_out;
	wire [`AXI_IDS_BITS-1:0] ar_de_ARID_S2_out;
	wire ar_de_ARVALID_S2_out;
	
	/* For invalid address */
	wire ar_de_INVALID_ADDR;
	wire ar_de_CULPRIT;
	wire [1:0] ar_de_DEC_SLAVE_ID_out;
	wire ar_de_Lock_AR_out;



// AW_ARBITRATOR output ports	
	wire [`AXI_ID_BITS-1:0] aw_arb_AWID_out;
	wire [`AXI_ADDR_BITS-1:0] aw_arb_AWADDR_out;
	wire [`AXI_LEN_BITS-1:0] aw_arb_AWLEN_out;
	wire [`AXI_SIZE_BITS-1:0] aw_arb_AWSIZE_out;
	wire [1:0] aw_arb_AWBURST_out;
    wire aw_arb_AWVALID_out;
	wire aw_arb_AW_IDLE_out;
	wire aw_arb_AW_LOCK_out;

// AW_DECODER output ports	
	wire [`AXI_IDS_BITS-1:0] aw_de_AWID_S0_out;
	wire [`AXI_ADDR_BITS-1:0] aw_de_AWADDR_S0_out;
	wire [`AXI_LEN_BITS-1:0] aw_de_AWLEN_S0_out;
	wire [`AXI_SIZE_BITS-1:0] aw_de_AWSIZE_S0_out;
	wire [1:0] aw_de_AWBURST_S0_out;
    wire aw_de_AWVALID_S0_out;
    wire [`AXI_IDS_BITS-1:0] aw_de_AWID_S1_out;
	wire [`AXI_ADDR_BITS-1:0] aw_de_AWADDR_S1_out;
	wire [`AXI_LEN_BITS-1:0] aw_de_AWLEN_S1_out;
	wire [`AXI_SIZE_BITS-1:0] aw_de_AWSIZE_S1_out;
	wire [1:0] aw_de_AWBURST_S1_out;
    wire aw_de_AWVALID_S1_out;
	wire [`AXI_IDS_BITS-1:0] aw_de_AWID_S2_out;
	wire aw_de_AWVALID_S2_out;
	//wire ar_de_AWREADY_M0_out;
    wire aw_de_AWREADY_M1_out;
	wire [1:0] aw_de_slave_ID_out;
	wire [`AXI_ID_BITS:0] aw_de_AWID_out;
	wire aw_de_AWREADY_to_AW_ARB_out;
	
//R_ARBITRATOR output ports 
	wire [`AXI_IDS_BITS-1:0] r_arb_RID_out;
	wire [`AXI_DATA_BITS-1:0] r_arb_RDATA_out;
	wire [1:0] r_arb_RRESP_out;
	wire r_arb_RLAST_out;
    wire r_arb_RVALID_out;
	wire [1:0] r_arb_SlaveID_out;
	
//R_DECODER output ports
	/* output to slave 0, 1 */
    wire r_de_RREADY_S0_out;
    wire r_de_RREADY_S1_out;
	wire r_de_RREADY_S2_out;
    /* output to master 0 */
    wire [`AXI_ID_BITS-1:0] r_de_RID_M0_out;
	wire [`AXI_DATA_BITS-1:0] r_de_RDATA_M0_out;
	wire [1:0] r_de_RRESP_M0_out;
	wire r_de_RLAST_M0_out;
	wire r_de_RVALID_M0_out;
    /* output to master 1 */
    wire [`AXI_ID_BITS-1:0] r_de_RID_M1_out;
	wire [`AXI_DATA_BITS-1:0] r_de_RDATA_M1_out;
	wire [1:0] r_de_RRESP_M1_out;
	wire r_de_RLAST_M1_out;
	wire r_de_RVALID_M1_out;
	wire r_de_DEC_MASTER_ID_out;
	wire r_de_Release_AR_out;
	wire r_dec_RREADY_to_AR_ARB_out;
	wire r_dec_RVALID_to_AR_ARB_out;
	
//W_ARBITRATOR output ports
	wire [`AXI_DATA_BITS-1:0] w_arb_WDATA_out;
	wire [`AXI_STRB_BITS-1:0] w_arb_WSTRB_out;
	wire w_arb_WLAST_out;
	wire w_arb_WVALID_out;
	wire w_arb_W_IDLE_out;


//W_DECODER output ports
    wire w_de_WREADY_M1_out;
    wire [`AXI_DATA_BITS-1:0] w_de_WDATA_S0_out;
	wire [`AXI_STRB_BITS-1:0] w_de_WSTRB_S0_out;
	wire w_de_WLAST_S0_out;
	wire w_de_WVALID_S0_out;
    wire [`AXI_DATA_BITS-1:0] w_de_WDATA_S1_out;
	wire [`AXI_STRB_BITS-1:0] w_de_WSTRB_S1_out;
	wire w_de_WLAST_S1_out;
	wire w_de_WVALID_S1_out;
	wire w_de_WREADY_AW_ARB_out;
	wire w_de_WVALID_S2_out;


//B_ARBITRATOR output ports
	wire [1:0] b_arb_SlaveID_out;
    wire [`AXI_IDS_BITS-1:0] b_arb_BID_out;
	wire [1:0] b_arb_BRESP_out;
	wire b_arb_BVALID_out;

//B_DECODER output ports
	wire b_de_BREADY_S0_out;
    wire b_de_BREADY_S1_out;
	wire b_de_BREADY_S2_out;
    wire [`AXI_ID_BITS-1:0] b_de_BID_M1_out;
	wire [1:0] b_de_BRESP_M1_out;
	wire b_de_BVALID_M1_out;
	wire b_de_Release_AW_out;

//VIRTUALSLAVE output ports
	wire vir_slave_ARREADY_out;
	wire [`AXI_IDS_BITS-1:0] vir_slave_RID_out;
	wire [1:0] vir_slave_RRESP_out;
	wire vir_slave_RVALID_out;
	wire vir_slave_AWREADY_out;
	wire vir_slave_WREADY_out;
	wire [`AXI_IDS_BITS-1:0] vir_slave_BID_out;
	wire [1:0] vir_slave_BRESP_out;
	wire vir_slave_BVALID_out;

	VIRTUALSLAVE virtualslave(
		.clk(ACLK),
		.rst(rst),
		.ARID(ar_de_ARID_S2_out),
		.ARVALID(ar_de_ARVALID_S2_out),
		.ARREADY(vir_slave_ARREADY_out),
		.RREADY(r_de_RREADY_S2_out),
		.RID(vir_slave_RID_out),
		.RRESP(vir_slave_RRESP_out),
		.RVALID(vir_slave_RVALID_out),
		.AWID(aw_de_AWID_S2_out),
		.AWVALID(aw_de_AWVALID_S2_out),
		.AWREADY(vir_slave_AWREADY_out),
		.WVALID(w_de_WVALID_S2_out),
		.WREADY(vir_slave_WREADY_out),
		.BREADY(),
		.BID(vir_slave_BID_out),
		.BRESP(vir_slave_BRESP_out),
		.BVALID(vir_slave_BVALID_out)
	);

	//---------- you should put your design here ----------//
	AR_ARBITRATOR ar_arbitrator(
		.clk(ACLK),
		.rst(rst),
		.DEC_SLAVE_ID(ar_de_DEC_SLAVE_ID_out),
		.RREADY(r_dec_RREADY_to_AR_ARB_out),
		.RVALID(r_dec_RVALID_to_AR_ARB_out),
		.ARID_M0(ARID_M0),
		.ARADDR_M0(ARADDR_M0),
		.ARLEN_M0(ARLEN_M0),
		.ARSIZE_M0(ARSIZE_M0),
		.ARBURST_M0(ARBURST_M0),
		.ARVALID_M0(ARVALID_M0),
		.ARID_M1(ARID_M1),
		.ARADDR_M1(ARADDR_M1),
		.ARLEN_M1(ARLEN_M1),
		.ARSIZE_M1(ARSIZE_M1),
		.ARBURST_M1(ARBURST_M1),
		.ARVALID_M1(ARVALID_M1),
		.ARREADY_S0(ARREADY_S0),
		.ARREADY_S1(ARREADY_S1),
		.ARREADY_S2(vir_slave_ARREADY_out),
		/* output ports */
		.MasterID(ar_arb_MasterID_out),
		.ARID(ar_arb_ARID_out),
		.ARADDR(ar_arb_ARADDR_out),
		.ARLEN(ar_arb_ARLEN_out),
		.ARSIZE(ar_arb_ARSIZE_out),
		.ARBURST(ar_arb_ARBURST_out),
		.ARVALID(ar_arb_ARVALID_out),
		.AR_LOCK(ar_arb_AR_LOCK_out),
		.AR_IDLE(ar_arb_AR_IDLE_out)
	);

	AR_DECODER ar_decoder(
		.AR_LOCK(ar_arb_AR_LOCK_out),
		.AR_IDLE(ar_arb_AR_IDLE_out),
		.MasterID(ar_arb_MasterID_out),
		.ARID(ar_arb_ARID_out),
		.ARADDR(ar_arb_ARADDR_out),
		.ARLEN(ar_arb_ARLEN_out),
		.ARSIZE(ar_arb_ARSIZE_out),
		.ARBURST(ar_arb_ARBURST_out),
		.ARVALID(ar_arb_ARVALID_out),
		/*inputs from slaves*/
		.ARREADY_S0(ARREADY_S0),
		.ARREADY_S1(ARREADY_S1),
		.ARREADY_S2(vir_slave_ARREADY_out),
		/*output ports*/
		.ARREADY_M0(ARREADY_M0),
		.ARREADY_M1(ARREADY_M1),
		.ARID_S0(ARID_S0),
		.ARADDR_S0(ARADDR_S0),
		.ARLEN_S0(ARLEN_S0),
		.ARSIZE_S0(ARSIZE_S0),
		.ARBURST_S0(ARBURST_S0),
		.ARVALID_S0(ARVALID_S0),
		.ARID_S1(ARID_S1),
		.ARADDR_S1(ARADDR_S1),
		.ARLEN_S1(ARLEN_S1),
		.ARSIZE_S1(ARSIZE_S1),
		.ARBURST_S1(ARBURST_S1),
		.ARVALID_S1(ARVALID_S1),
		.ARID_S2(ar_de_ARID_S2_out),
		.ARVALID_S2(ar_de_ARVALID_S2_out),
		//.INVALID_ADDR(ar_de_INVALID_ADDR),
		//.CULPRIT(ar_de_CULPRIT),
		.DEC_SLAVE_ID(ar_de_DEC_SLAVE_ID_out)
		//.Lock_AR(ar_de_Lock_AR_out)
	);

	AW_ARBITRATOR aw_arbitrator(
		//.Release(b_de_Release_AW_out),
		.clk(ACLK),
		.rst(rst),
    	.AWID_M1(AWID_M1),
    	.AWADDR_M1(AWADDR_M1),
   		.AWLEN_M1(AWLEN_M1),
    	.AWSIZE_M1(AWSIZE_M1),
    	.AWBURST_M1(AWBURST_M1),
		.AWVALID_M1(AWVALID_M1),
		.AWREADY(aw_de_AWREADY_to_AW_ARB_out),
		.WVALID(w_arb_WVALID_out),
		.WREADY(w_de_WREADY_AW_ARB_out),
		/*output ports*/
    	.AWID(aw_arb_AWID_out),
		.AWADDR(aw_arb_AWADDR_out),
		.AWLEN(aw_arb_AWLEN_out),
		.AWSIZE(aw_arb_AWSIZE_out),
		.AWBURST(aw_arb_AWBURST_out),
    	.AWVALID(aw_arb_AWVALID_out),
		.AW_IDLE(aw_arb_AW_IDLE_out),
		.AW_LOCK(aw_arb_AW_LOCK_out)
	);


	AW_DECODER aw_decoder(
		.AW_IDLE(aw_arb_AW_IDLE_out),
		.AW_LOCK(aw_arb_AW_LOCK_out),
		.AWID(aw_arb_AWID_out),
		.AWADDR(aw_arb_AWADDR_out),
		.AWLEN(aw_arb_AWLEN_out),
		.AWSIZE(aw_arb_AWSIZE_out),
		.AWBURST(aw_arb_AWBURST_out),
		.AWVALID(aw_arb_AWVALID_out),
		 /* input from slave */
    	.AWREADY_S0(AWREADY_S0),
		.AWREADY_S1(AWREADY_S1),
		.AWREADY_S2(vir_slave_AWREADY_out),
		/*output ports*/
    	.AWID_S0(AWID_S0),
		.AWADDR_S0(AWADDR_S0),
		.AWLEN_S0(AWLEN_S0),
		.AWSIZE_S0(AWSIZE_S0),
		.AWBURST_S0(AWBURST_S0),
    	.AWVALID_S0(AWVALID_S0),
		.AWID_S1(AWID_S1),
		.AWADDR_S1(AWADDR_S1),
		.AWLEN_S1(AWLEN_S1),
		.AWSIZE_S1(AWSIZE_S1),
		.AWBURST_S1(AWBURST_S1),
    	.AWVALID_S1(AWVALID_S1),
		.AWID_S2(aw_de_AWID_S2_out),
		.AWVALID_S2(aw_de_AWVALID_S2_out),
		/* output to Master0 */
    	//.AWREADY_M0(ar_de_AWREADY_M0_out),
    	.AWREADY_M1(AWREADY_M1),
		.slave_ID(aw_de_slave_ID_out),
		.AWREADY_to_AW_ARB(aw_de_AWREADY_to_AW_ARB_out)
);
	
	R_ARBITRATOR r_arbitrator(
		.clk(ACLK),
		.rst(rst),
		.DEC_MASTER_ID(r_de_DEC_MASTER_ID_out),
		.RID_S0(RID_S0),
		.RDATA_S0(RDATA_S0),
		.RRESP_S0(RRESP_S0),
		.RLAST_S0(RLAST_S0),
		.RVALID_S0(RVALID_S0),
		.RID_S1(RID_S1),
		.RDATA_S1(RDATA_S1),
		.RRESP_S1(RRESP_S1),
		.RLAST_S1(RLAST_S1),
		.RVALID_S1(RVALID_S1),
		.RID_S2(vir_slave_RID_out),
		.RRESP_S2(vir_slave_RRESP_out),
		.RVALID_S2(vir_slave_RVALID_out),
		.RREADY_M0(RREADY_M0),
		.RREADY_M1(RREADY_M1),
		/*output ports*/
		.RID(r_arb_RID_out),
		.RDATA(r_arb_RDATA_out),
		.RRESP(r_arb_RRESP_out),
		.RLAST(r_arb_RLAST_out),
		.RVALID(r_arb_RVALID_out),
		.SlaveID(r_arb_SlaveID_out)
	);

	R_DECODER r_decoder(
		.clk(ACLK),
		.rst(rst),
		//.INVALID_ADDR(ar_de_INVALID_ADDR),
		//.CULPRIT(ar_de_CULPRIT),
		.SlaveID(r_arb_SlaveID_out),
		.RID(r_arb_RID_out),
		.RDATA(r_arb_RDATA_out),
		.RRESP(r_arb_RRESP_out),
		.RLAST(r_arb_RLAST_out),
		.RVALID(r_arb_RVALID_out),
		.RREADY_M0(RREADY_M0),
		.RREADY_M1(RREADY_M1),
		/*output ports*/
		.RREADY_S0(RREADY_S0),
		.RREADY_S1(RREADY_S1),
		.RREADY_S2(r_de_RREADY_S2_out),
		.RID_M0(RID_M0),
		.RDATA_M0(RDATA_M0),
		.RRESP_M0(RRESP_M0),
		.RLAST_M0(RLAST_M0),
		.RVALID_M0(RVALID_M0),
		.RID_M1(RID_M1),
		.RDATA_M1(RDATA_M1),
		.RRESP_M1(RRESP_M1),
		.RLAST_M1(RLAST_M1),
		.RVALID_M1(RVALID_M1),
		.DEC_MASTER_ID(r_de_DEC_MASTER_ID_out),
		.RREADY_to_AR_ARB(r_dec_RREADY_to_AR_ARB_out),
		.RVALID_to_AR_ARB(r_dec_RVALID_to_AR_ARB_out)
		//.Release_AR(r_de_Release_AR_out)
	);
	W_ARBITRATOR w_arbitrator(
   		.WDATA_M1(WDATA_M1),
		.WSTRB_M1(WSTRB_M1),
		.WLAST_M1(WLAST_M1),
		.WVALID_M1(WVALID_M1),
		.AW_IDLE(aw_arb_AW_IDLE_out),
		.WDATA(w_arb_WDATA_out),
		.WSTRB(w_arb_WSTRB_out),
		.WLAST(w_arb_WLAST_out),
		.WVALID(w_arb_WVALID_out),
		.W_IDLE(w_arb_W_IDLE_out)
	);
	W_DECODER w_decoder(
    	.clk(ACLK),
    	.rst(rst),
		.W_IDLE(w_arb_W_IDLE_out),
		.AW_LOCK(aw_arb_AW_LOCK_out),
		.AWVALID_in(aw_arb_AWVALID_out),
    	.slave_ID_in(aw_de_slave_ID_out),
    	.WDATA(w_arb_WDATA_out),
		.WSTRB(w_arb_WSTRB_out),
		.WLAST(w_arb_WLAST_out),
		.WVALID(w_arb_WVALID_out),
    	.WREADY_S0(WREADY_S0),
		.WREADY_S1(WREADY_S1),
		.WREADY_S2(vir_slave_WREADY_out),
    	.WREADY_M1(WREADY_M1),
    	.WDATA_S0(WDATA_S0),
		.WSTRB_S0(WSTRB_S0),
		.WLAST_S0(WLAST_S0),
		.WVALID_S0(WVALID_S0),
    	.WDATA_S1(WDATA_S1),
		.WSTRB_S1(WSTRB_S1),
		.WLAST_S1(WLAST_S1),
		.WVALID_S1(WVALID_S1),
		.WVALID_S2(w_de_WVALID_S2_out),
		.WREADY_AW_ARB(w_de_WREADY_AW_ARB_out)
    );


	B_ARBITRATOR b_arbitrator(
		.clk(ACLK),
		.rst(rst),
		.BID_S0(BID_S0),
		.BRESP_S0(BRESP_S0),
		.BVALID_S0(BVALID_S0),
		.BID_S1(BID_S1),
		.BRESP_S1(BRESP_S1),
		.BVALID_S1(BVALID_S1),
		.BID_S2(vir_slave_BID_out),
		.BRESP_S2(vir_slave_BRESP_out),
		.BVALID_S2(vir_slave_BVALID_out),
		.BREADY_M1(BREADY_M1),
		/* output ports */
		.SlaveID(b_arb_SlaveID_out),
		.BID(b_arb_BID_out),
		.BRESP(b_arb_BRESP_out),
		.BVALID(b_arb_BVALID_out)
	);

	B_DECODER b_decoder(
		.clk(ACLK),
		.rst(rst),
		/* for invalid address */
		// .SlaveID_from_aw_de(aw_de_slave_ID_out),
	    // 	.AWID_from_aw_de(AWID_M1),
		/* ------------------- */
		.SlaveID(b_arb_SlaveID_out),
		.BID(b_arb_BID_out),
		.BRESP(b_arb_BRESP_out),
		.BVALID(b_arb_BVALID_out),
		.BREADY_M1(BREADY_M1),
		/* output ports */
		.BREADY_S0(BREADY_S0),
		.BREADY_S1(BREADY_S1),
		.BREADY_S2(b_de_BREADY_S2_out),
		.BID_M1(BID_M1),
		.BRESP_M1(BRESP_M1),
		.BVALID_M1(BVALID_M1)
		// .Release_AW(b_de_Release_AW_out)
	);
	
	endmodule
