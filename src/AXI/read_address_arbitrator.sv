module read_address_arbitration(
    input [`AXI_ID_BITS-1:0] ARID_M0,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	input [`AXI_LEN_BITS-1:0] ARLEN_M0,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	input [1:0] ARBURST_M0,
	input ARVALID_M0,
    input [`AXI_ID_BITS-1:0] ARID_M1,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	input [`AXI_LEN_BITS-1:0] ARLEN_M1,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	input [1:0] ARBURST_M1,
	input ARVALID_M1,
    output [`AXI_ID_BITS-1:0] ARID_ARB,
	output [`AXI_ADDR_BITS-1:0] ARADDR_ARB,
	output [`AXI_LEN_BITS-1:0] ARLEN_ARB,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_ARB,
	output [1:0] ARBURST_ARB,
	output ARVALID_ARB  
);
logic M0_flag;
logic M1_flag;
always_comb begin
    if (ARVALID_M0 & ARVALID_M1 & ~M0_flag & ~M1_flag)begin
        ARID_ARB = ARID_M0;
        ARADDR_ARB = ARADDR_M0;
        ARLEN_ARB = ARLEN_M0;
        ARSIZE_ARB = ARSIZE_M0;
        ARBURST_ARB = ARBURST_M0;
        M0_flag = 1'b1;
        M1_flag = 1'b0;
    end
    else if (ARVALID_M0 & ARVALID_M1 & M0_flag & ~M1_flag)begin
        ARID_ARB = ARID_M0;
        ARADDR_ARB = ARADDR_M0;
        ARLEN_ARB = ARLEN_M0;
        ARSIZE_ARB = ARSIZE_M0;
        ARBURST_ARB = ARBURST_M0;
        M0_flag = 1'b1;
        M1_flag = 1'b0;
    end
    else if (ARVALID_M0 & ARVALID_M1 & ~M0_flag & M1_flag)begin
        ARID_ARB = ARID_M1;
        ARADDR_ARB = ARADDR_M1;
        ARLEN_ARB = ARLEN_M1;
        ARSIZE_ARB = ARSIZE_M1;
        ARBURST_ARB = ARBURST_M1;
        M0_flag = 1'b0;
        M1_flag = 1'b1;
    end
    else if (ARVALID_M0 & ~ARADDR_M1)begin
        ARID_ARB = ARID_M0;
        ARADDR_ARB = ARADDR_M0;
        ARLEN_ARB = ARLEN_M0;
        ARSIZE_ARB = ARSIZE_M0;
        ARBURST_ARB = ARBURST_M0;
        M0_flag = 1'b1;
        M1_flag = 1'b0;
    end
    else if (~ARVALID_M0 & ARADDR_M1)begin
        ARID_ARB = ARID_M1;
        ARADDR_ARB = ARADDR_M1;
        ARLEN_ARB = ARLEN_M1;
        ARSIZE_ARB = ARSIZE_M1;
        ARBURST_ARB = ARBURST_M1;
        M0_flag = 1'b0;
        M1_flag = 1'b1;  
    end
    else begin
        M0_flag = 1'b0;
        M1_flag = 1'b0;
    end

end

endmodule