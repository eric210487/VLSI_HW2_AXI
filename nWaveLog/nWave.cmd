wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/eric/Documents/VLSI/Hw2/N26091530/build/top.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalClose -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg"
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1/i_SRAM"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvSetPosition -win $_nWave1 {("G2" 4)}
wvSetPosition -win $_nWave1 {("G2" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 3 4 )} 
wvSetPosition -win $_nWave1 {("G2" 4)}
wvSetPosition -win $_nWave1 {("G2" 4)}
wvSetPosition -win $_nWave1 {("G2" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 3 4 )} 
wvSetPosition -win $_nWave1 {("G2" 4)}
wvGetSignalClose -win $_nWave1
wvSaveSignal -win $_nWave1 \
           "/home/eric/Documents/VLSI/Hw2/N26091530/build/signal.rc"
wvSetCursor -win $_nWave1 39571388.979307 -snap {("G3" 0)}
wvSetCursor -win $_nWave1 39571485.678143 -snap {("G2" 3)}
wvSetCursor -win $_nWave1 39664287.316814 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 39934384.794348 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 39935931.975720
wvSetCursor -win $_nWave1 39935126.152089
wvSetCursor -win $_nWave1 39934642.657910
wvSetCursor -win $_nWave1 39934481.493183
wvSelectGroup -win $_nWave1 {G3}
wvSelectGroup -win $_nWave1 {G2}
wvSelectGroup -win $_nWave1 {G3}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/ex0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0"
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data1\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data2\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/result\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data1\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data2\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/result\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G4}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/ex0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/id0/control0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/id0/idexreg0"
wvGetSignalSetScope -win $_nWave1 \
           "/top_tb/TOP/cpu_wrapper0/cpu0/id0/hazard_detector0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/id0/idexreg0"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper0/cpu0/id0/registers0"
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data1\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data2\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/result\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/top_tb/TOP/cpu_wrapper0/cpu0/id0/registers0/reg_\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/clk} \
{/top_tb/TOP/rst} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/data_out\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/if0/if_id_reg/pc_out\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/DM1/DO\[31:0\]} \
{/top_tb/TOP/DM1/DI\[31:0\]} \
{/top_tb/TOP/DM1/OE} \
{/top_tb/TOP/DM1/WEB\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data1\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/data2\[31:0\]} \
{/top_tb/TOP/cpu_wrapper0/cpu0/ex0/alu0/result\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/top_tb/TOP/cpu_wrapper0/cpu0/id0/registers0/reg_\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetPosition -win $_nWave1 {("G4" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvExpandBus -win $_nWave1 {("G4" 1)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G4" 10 )} 
wvSelectSignal -win $_nWave1 {( "G4" 14 )} 
wvScrollUp -win $_nWave1 12
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 39905436.386211 -snap {("G4" 19)}
wvSetCursor -win $_nWave1 39877228.410304 -snap {("G4" 20)}
wvSetCursor -win $_nWave1 39836824.719795 -snap {("G4" 19)}
wvSetCursor -win $_nWave1 39804792.486850 -snap {("G4" 19)}
wvSetCursor -win $_nWave1 39804792.486850 -snap {("G4" 18)}
wvSetCursor -win $_nWave1 39790760.253910 -snap {("G4" 18)}
wvSetCursor -win $_nWave1 39790760.253910 -snap {("G4" 19)}
wvSetCursor -win $_nWave1 39806384.794354 -snap {("G4" 18)}
wvSetCursor -win $_nWave1 39792613.648256 -snap {("G4" 18)}
wvSetCursor -win $_nWave1 39795466.263912 -snap {("G4" 18)}
wvSetCursor -win $_nWave1 39794354.227300 -snap {("G4" 19)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 2
wvScrollUp -win $_nWave1 3
wvScrollUp -win $_nWave1 2
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvSetPosition -win $_nWave1 {("G4" 0)}
wvCollapseGroup -win $_nWave1 "G4"
wvSelectGroup -win $_nWave1 {G4}
wvRenameGroup -win $_nWave1 {G4} {Register}
wvSaveSignal -win $_nWave1 \
           "/home/eric/Documents/VLSI/Hw2/N26091530/build/signal.rc"
wvSaveSignal -win $_nWave1 \
           "/home/eric/Documents/VLSI/Hw2/N26091530/build/signal.rc"
