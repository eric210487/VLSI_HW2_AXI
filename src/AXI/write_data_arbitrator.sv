module write_data_arbitrator(
    input ACLK,
    input ARESETn,
    input [`AXI_DATA_BITS-1:0] WDATA_M1,
    input [`AXI_STRB_BITS-1:0] WSTRB_M1,
    input WLAST_M1,
    input WVALID_M1,
    output logic [`AXI_DATA_BITS-1:0] WDATA_ARB,
    output logic [`AXI_STRB_BITS-1:0] WSTRB_ARB,
    output logic WLAST_ARB,
    output logic WVALID_ARB,
    input AWREADY_M1,
    input AWVALID_ARB,
    input WREADY_M1
);
logic W_lock;
logic W_lock_reg;

always_ff @(posedge ACLK, negedge ARESETn) begin
    if(~ARESETn)begin
        W_lock_reg <= 1'b1;
    end
    else begin
        W_lock_reg <= W_lock;
    end
end

always_comb begin
    if(W_lock_reg)begin
        if(AWREADY_M1&AWVALID_ARB)begin
        WDATA_ARB = WDATA_M1;
        WSTRB_ARB = WSTRB_M1;
        WLAST_ARB = WLAST_M1;
        WVALID_ARB = WVALID_M1;
	    W_lock = 1'b0;
        end
        else begin
            WDATA_ARB = 32'b0;
            WSTRB_ARB = 4'b0;
            WLAST_ARB = 1'b0;
            WVALID_ARB = 1'b0;
	    W_lock = 1'b1; 
        end
    end
    else if(WVALID_M1 & ~W_lock_reg & WREADY_M1)begin
        WDATA_ARB = WDATA_M1;
        WSTRB_ARB = WSTRB_M1;
        WLAST_ARB = WLAST_M1;
        WVALID_ARB = WVALID_M1; 
        W_lock = 1'b1;
    end
    else if(WVALID_M1 & ~W_lock_reg)begin
        WDATA_ARB = WDATA_M1;
        WSTRB_ARB = WSTRB_M1;
        WLAST_ARB = WLAST_M1;
        WVALID_ARB = WVALID_M1; 
        W_lock = 1'b0;
    end
    else if(~W_lock_reg)begin
        WDATA_ARB = 32'b0;
        WSTRB_ARB = 4'b0;
        WLAST_ARB = 1'b0;
        WVALID_ARB = 1'b0; 
        W_lock = 1'b0;
    end
    else begin
	WDATA_ARB = 32'b0;
        WSTRB_ARB = 4'b0;
        WLAST_ARB = 1'b0;
        WVALID_ARB = 1'b0; 
        W_lock = 1'b0;
    end
end
    
endmodule
