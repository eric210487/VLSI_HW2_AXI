module write_address_arbitrator(
	input ACLK,
	input ARESETn,
    input [`AXI_ID_BITS-1:0] AWID_M1,
	input [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	input [`AXI_LEN_BITS-1:0] AWLEN_M1,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	input [1:0] AWBURST_M1,
	input AWVALID_M1,
    output logic [`AXI_ID_BITS-1:0] AWID_ARB,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_ARB,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_ARB,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_ARB,
	output logic [1:0] AWBURST_ARB,
	output logic AWVALID_ARB,
	input BVALID_ARB,
	input BREADY_M1,
	input AWREADY_M1
);
logic AW_lock;
logic AW_lock_reg;
always_ff @(posedge ACLK, negedge ARESETn) begin
	if(~ARESETn)begin
		AW_lock_reg <= 1'b0;
	end
	else begin
		AW_lock_reg <= AW_lock;
	end
end
always_comb begin
	if(AW_lock_reg)begin
		if(BVALID_ARB & BREADY_M1)begin
			AWID_ARB = 4'b0;
			//AWADDR_ARB = 32'h30000;
			AWLEN_ARB = 4'b0;
			AWSIZE_ARB = 3'b0;
			AWBURST_ARB = 2'b0;
			AWVALID_ARB = 1'b0;
			AW_lock = 1'b0;
		end
		else begin
			//AWID_ARB = 4'b0;
			//AWADDR_ARB = 32'h30000;
			//AWLEN_ARB = 4'b0;
			//AWSIZE_ARB = 3'b0;
			//AWBURST_ARB = 2'b0;
			AWVALID_ARB = 1'b0;
			AW_lock = 1'b1;
		end
	end
    else if(AWVALID_M1 & ~AW_lock_reg & AWREADY_M1)begin
            AWID_ARB = AWID_M1;
	    AWADDR_ARB = AWADDR_M1;
	    AWLEN_ARB = AWLEN_M1;
	    AWSIZE_ARB = AWSIZE_M1;
	    AWBURST_ARB = AWBURST_M1;
	    AWVALID_ARB = AWVALID_M1;
		AW_lock = 1'b1;
    end 
    else if(AWVALID_M1 & ~AW_lock_reg)begin
        AWID_ARB = AWID_M1;
	    AWADDR_ARB = AWADDR_M1;
	    AWLEN_ARB = AWLEN_M1;
	    AWSIZE_ARB = AWSIZE_M1;
	    AWBURST_ARB = AWBURST_M1;
	    AWVALID_ARB = AWVALID_M1;
		AW_lock = 1'b0;
    end 
    else if(~AW_lock_reg)begin
		AWID_ARB = 4'b0;
		AWADDR_ARB = 32'h30000;
		AWLEN_ARB = 4'b0;
		AWSIZE_ARB = 3'b0;
		AWBURST_ARB = 2'b0;
		AWVALID_ARB = 1'b0;
		AW_lock = 1'b0;
    end
    else begin
	        AWID_ARB = 4'b0;
		AWADDR_ARB = 32'h30000;
		AWLEN_ARB = 4'b0;
		AWSIZE_ARB = 3'b0;
		AWBURST_ARB = 2'b0;
		AWVALID_ARB = 1'b0;
		AW_lock = 1'b0;
    end
end




endmodule
