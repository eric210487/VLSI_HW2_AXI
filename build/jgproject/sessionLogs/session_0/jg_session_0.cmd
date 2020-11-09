#----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2018.03
# platform  : Linux 3.10.0-862.9.1.el7.x86_64
# version   : 2018.03p001 64 bits
# build date: 2018.04.24 18:13:05 PDT
#----------------------------------------
# started Sat Nov 07 16:50:51 CST 2020
# hostname  : vlsicad8
# pid       : 24807
# arguments : '-label' 'session_0' '-console' 'vlsicad8:36371' '-style' 'windows' '-data' 'AQAAADx/////AAAAAAAAA3oBAAAAEABMAE0AUgBFAE0ATwBWAEU=' '-proj' '/home/user2/vsd20/vsd2049/VLSI_HW2_AXI/build/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/user2/vsd20/vsd2049/VLSI_HW2_AXI/build/jgproject/.tmp/.initCmds.tcl' '../script/jg_bridge.tcl'
#DO NOT MODIFY THIS FILE
set ABVIP_INST_DIR /usr/cad/cadence/VIPCAT/cur/tools/abvip
set vip_dir $::env(vip_dir)
set maxpend $::env(maxpend)

abvip -set_location $ABVIP_INST_DIR
set_visualize_auto_load_debugging_tables on
analyze -f $vip_dir/bridge_duv/jg.f -sv09
elaborate -top top -param top.axi_master_0.READONLY_INTERFACE 1 -param top.axi_master_1.READONLY_INTERFACE 0\
-param top.axi_master_0.MAXPENDING $maxpend -param top.axi_master_1.MAXPENDING $maxpend\
-param top.axi_slave_0.MAXPENDING $maxpend -param top.axi_slave_1.MAXPENDING $maxpend\

clock aclk_m
clock aclk_s
reset ~aresetn_m ~aresetn_s


assert -disable top.axi_master_0.genStableChks.genStableChksRDInf.genAXI4Full.slave_r_ruser_stable 
assert -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_fixed_arlen

assert -disable top.axi_master_1.genStableChks.genStableChksRDInf.genAXI4Full.slave_r_ruser_stable
assert -disable top.axi_master_1.genStableChks.genStableChksWRInf.genAXI4Full.slave_b_buser_stable
assert -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave
assume -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assume -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assume -disable top.axi_master_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assume -disable top.axi_master_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen

assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_0.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_0.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_1.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_1.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#data integrity
assume {((axi_slave_0.rready == 0) && (axi_slave_0.rvalid == 1)) |=> $stable(axi_slave_0.rdata)}
assume {((axi_slave_1.rready == 0) && (axi_slave_1.rvalid == 1)) |=> $stable(axi_slave_1.rdata)}

prove -all

visualize -violation -property <embedded>::top.axi_master_0.genStableChks.genStableChksRDInf.slave_r_rvalid_stable -new_window