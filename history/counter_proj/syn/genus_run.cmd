# Cadence Genus(TM) Synthesis Solution, Version 21.14-s082_1, built Jun 23 2022 14:32:08

# Date: Thu Sep 17 13:16:36 2026
# Host: tcevlsi.tce.edu (x86_64 w/Linux 4.18.0-553.83.1.el8_10.x86_64) (16cores*24cpus*1physical cpu*13th Gen Intel(R) Core(TM) i7-13700 30720KB)
# OS:   Red Hat Enterprise Linux release 8.7(Ootpa)

source syn.tcl
[root@tcevlsi syn]# genus -files syn.tcl -log genus_run.log
2026/09/17 13:16:32 WARNING This OS does not appear to be a Cadence supported Linux configuration.
2026/09/17 13:16:32 For more info, please run CheckSysConf in <cdsRoot/tools.lnx86/bin/checkSysConf <productId>
TMPDIR is being set to /tmp/genus_temp_17448_tcevlsi.tce.edu_root_0yf9se
Cadence Genus(TM) Synthesis Solution.
Copyright 2022 Cadence Design Systems, Inc. All rights reserved worldwide.
Cadence and the Cadence logo are registered trademarks and Genus is a trademark
of Cadence Design Systems, Inc. in the United States and other countries.
[13:16:36.275873] Configured Lic search path (21.01-s002): 5280@14.139.1.126
Version: 21.14-s082_1, built Thu Jun 23 02:02:08 PDT 2022
Options: -files syn.tcl -log genus_run.log
Date:    Thu Sep 17 13:16:36 2026
Host:    tcevlsi.tce.edu (x86_64 w/Linux 4.18.0-553.83.1.el8_10.x86_64) (16cores*24cpus*1physical cpu*13th Gen Intel(R) Core(TM) i7-13700 30720KB) (65344980KB)
PID:     17448
OS:      Red Hat Enterprise Linux release 8.7(Ootpa)
[13:16:38.129315] Periodic Lic check successful
[13:16:38.129323] Feature usage summary:
[13:16:38.129323] Genus_Synthesis
Checking out license: Genus_Synthesis
***********************************************************************************************************
***********************************************************************************************************
Loading tool scripts...
Finished loading tool scripts (5 seconds elapsed).
@genus 1> source syn.tcl
@file(syn.tcl) 2: set_db library /home/install/FOUNDRY/digital/90nm/dig/lib/typical.lib
Threads Configured:3
Message Summary for Library typical.lib:
****************************************
Missing a function attribute in the output pin definition. [LBR-518]: 1
Missing library level attribute. [LBR-516]: 1
****************************************
 
Info    : Created nominal operating condition. [LBR-412]
: Operating condition '_nominal_' was created for the PVT values (1.000000, 1.000000, 25.000000) in library 'typical.lib'.
: The nominal operating condition is represented, either by the nominal PVT values specified in the library source (via nom_process,nom_voltage and nom_temperature respectively), or by the default PVT values (1.0,1.0,1.0).
Setting attribute of root '/': 'library' = /home/install/FOUNDRY/digital/90nm/dig/lib/typical.lib
@file(syn.tcl) 7: read_hdl ../rtl/counter.v
@file(syn.tcl) 11: elaborate
Library has 324 usable logic and 128 usable sequential lib-cells.
Info    : Elaborating Design. [ELAB-1]
: Elaborating top-level block 'counter' from file '../rtl/counter.v'.
Info    : Done Elaborating Design. [ELAB-3]
: Done elaborating 'counter'.
Checking for analog nets...
Check completed for analog nets.
Checking for source RTL...
Check completed for source RTL.
Running Unified Mux Engine Tricks...
Completed Unified Mux Engine Tricks
Stage: post_elab
--------------------------------------------------------
| Trick             | Accepts | Rejects | Runtime (ms) |
--------------------------------------------------------
| ume_constant_bmux |       0 |       0 |         0.00 |
--------------------------------------------------------
Starting clip mux common data inputs [v1.0] (stage: post_elab, startdef: counter, recur: true)
Completed clip mux common data inputs (accepts: 0, rejects: 0, runtime: 0.000s)
Starting clip the non-user hierarchies [v2.0] (stage: post_elab, startdef: counter, recur: true)
Completed clip the non-user hierarchies (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: post_elab
---------------------------------------------------------
| Transform          | Accepts | Rejects | Runtime (ms) |
---------------------------------------------------------
| hlo_clip_mux_input |       0 |       0 |         0.00 |
| hlo_clip           |       0 |       0 |         0.00 |
---------------------------------------------------------
UM:   flow.cputime  flow.realtime  timing.setup.tns  timing.setup.wns  snapshot
UM:*                                                                   elaborate
@file(syn.tcl) 16: create_clock -name clk -period 10 [get_ports clk]
@file(syn.tcl) 21: syn_generic
Stage: pre_early_cg
------------------------------------------------
| Transform | Accepts | Rejects | Runtime (ms) |
------------------------------------------------
------------------------------------------------
Starting mux data reorder optimization [v1.0] (stage: pre_to_gen_setup, startdef: counter, recur: true)
Completed mux data reorder optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: pre_to_gen_setup
------------------------------------------------------
| Transform       | Accepts | Rejects | Runtime (ms) |
------------------------------------------------------
| hlo_mux_reorder |       0 |       0 |         0.00 |
------------------------------------------------------
Info    : Synthesizing. [SYNTH-1]
: Synthesizing 'counter' to generic gates using 'medium' effort.
PBS_Generic-Start - Elapsed_Time 0, CPU_Time 0.0
stamp 'PBS_Generic-Start' being created for table 'pbs_debug'
Total Time (Wall) |  Stage Time (Wall)  |   % (Wall)   |    Date - Time     |  Memory   | Stage
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:04(00:00:02) |  00:00:00(00:00:00) |   0.0(  0.0) |   13:16:43 (Sep17) |  281.1 MB | PBS_Generic-Start
--------------------+---------------------+--------------+--------------------+-----------+----------------------
Number of threads: 8 * 1   (id: pbs_debug, time_info v1.57)
Info: (*N*) indicates data that was populated from previously saved time_info database
Info: CPU time includes time of parent + longest thread
TNS Restructuring config: no_value at stage: generic applied.
Info    : Partition Based Synthesis execution skipped. [PHYS-752]
: Design size is less than the partition size '100000' for distributed generic optimization to kick in.
Starting mux data reorder optimization [v1.0] (stage: pre_to_gen_setup, startdef: counter, recur: true)
Completed mux data reorder optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: pre_to_gen_setup
------------------------------------------------------
| Transform       | Accepts | Rejects | Runtime (ms) |
------------------------------------------------------
| hlo_mux_reorder |       0 |       0 |         0.00 |
------------------------------------------------------
Starting mux data reorder optimization [v1.0] (stage: post_to_gen_setup, startdef: counter, recur: true)
Completed mux data reorder optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: post_to_gen_setup
------------------------------------------------------
| Transform       | Accepts | Rejects | Runtime (ms) |
------------------------------------------------------
| hlo_mux_reorder |       0 |       0 |         0.00 |
------------------------------------------------------
Running Unified Mux Engine Tricks...
Completed Unified Mux Engine Tricks
Stage: pre_hlo_rtlopt
--------------------------------------------
| Trick | Accepts | Rejects | Runtime (ms) |
--------------------------------------------
--------------------------------------------
Starting infer macro optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed infer macro optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting decode mux sandwich optimization [v2.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed decode mux sandwich optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting decode mux optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed decode mux optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting chop wide muxes [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed chop wide muxes (accepts: 0, rejects: 0, runtime: 0.000s)
Starting common data mux cascade opt [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed common data mux cascade opt (accepts: 0, rejects: 0, runtime: 0.000s)
Starting mux input consolidation [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed mux input consolidation (accepts: 0, rejects: 0, runtime: 0.000s)
Starting constant-data mux optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed constant-data mux optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting chain-to-tree inequality transform [v2.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed chain-to-tree inequality transform (accepts: 0, rejects: 0, runtime: 0.000s)
Starting reconvergence optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed reconvergence optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting logic restructure optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed logic restructure optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting common select mux optimization [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed common select mux optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Starting identity transform [v3.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed identity transform (accepts: 0, rejects: 0, runtime: 0.000s)
Starting reduce operator chain [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed reduce operator chain (accepts: 0, rejects: 0, runtime: 0.000s)
Starting common data mux cascade opt [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed common data mux cascade opt (accepts: 0, rejects: 0, runtime: 0.000s)
Starting mux input consolidation [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed mux input consolidation (accepts: 0, rejects: 0, runtime: 0.001s)
Starting optimize datapath elements [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed optimize datapath elements (accepts: 0, rejects: 0, runtime: 0.000s)
Starting datapath recasting [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed datapath recasting (accepts: 0, rejects: 0, runtime: 0.000s)
Starting clip mux common data inputs [v1.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed clip mux common data inputs (accepts: 0, rejects: 0, runtime: 0.000s)
Starting clip the non-user hierarchies [v2.0] (stage: pre_rtlopt, startdef: counter, recur: true)
Completed clip the non-user hierarchies (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: pre_rtlopt
----------------------------------------------------------------
| Transform                 | Accepts | Rejects | Runtime (ms) |
----------------------------------------------------------------
| hlo_infer_macro           |       0 |       0 |         0.00 |
| hlo_decode_mux_sandwich   |       0 |       0 |         0.00 |
| hlo_mux_decode            |       0 |       0 |         0.00 |
| hlo_chop_mux              |       0 |       0 |         0.00 |
| hlo_mux_cascade_opt       |       0 |       0 |         0.00 |
| hlo_mux_consolidation     |       0 |       0 |         0.00 |
| hlo_constant_mux_opt      |       0 |       0 |         0.00 |
| hlo_inequality_transform  |       0 |       0 |         0.00 |
| hlo_reconv_opt            |       0 |       0 |         0.00 |
| hlo_restructure           |       0 |       0 |         0.00 |
| hlo_common_select_muxopto |       0 |       0 |         0.00 |
| hlo_identity_transform    |       0 |       0 |         0.00 |
| hlo_reduce_operator_chain |       0 |       0 |         0.00 |
| hlo_mux_cascade_opt       |       0 |       0 |         0.00 |
| hlo_mux_consolidation     |       0 |       0 |         1.00 |
| hlo_optimize_datapath     |       0 |       0 |         0.00 |
| hlo_datapath_recast       |       0 |       0 |         0.00 |
| hlo_clip_mux_input        |       0 |       0 |         0.00 |
| hlo_clip                  |       0 |       0 |         0.00 |
----------------------------------------------------------------
Running Unified Mux Engine Tricks...
Completed Unified Mux Engine Tricks
Stage: post_hlo_rtlopt
--------------------------------------------------
| Trick       | Accepts | Rejects | Runtime (ms) |
--------------------------------------------------
| ume_runtime |       0 |       0 |         0.00 |
--------------------------------------------------
Number of big hc bmuxes before = 0
Info    : Pre-processed datapath logic. [DPOPT-6]
: No pre-processing optimizations applied to datapath logic in 'counter'.
Info    : Optimizing datapath logic. [DPOPT-1]
: Optimizing datapath logic in 'counter'.
Info    : Implementing datapath configurations. [DPOPT-3]
: Implementing datapath configurations for 'CDN_DP_region_0_0'
CSAGen Prep Share:0 Re-Write:0 Speculation: 0
MaxCSA: Successfully built Maximal CSA Expression Expr0
CDN_DP_region_0_0 level = 0 loads = 0 drivers = 0
CDN_DP_region_0_0_c0 in counter: area: 61033520 ,dp = 1 mux = 0 sg = slow         worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
skipped
CDN_DP_region_0_0_c1 in counter: area: 41960545 ,dp = 1 mux = 0 sg = fast         worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c2 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_slow    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c3 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c4 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c5 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c6 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
CDN_DP_region_0_0_c7 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
is current best
Best config: CDN_DP_region_0_0_c7 in counter: area: 41960545 ,dp = 1 mux = 0 sg = very_fast    worst_clk_period: -1.0000
wns: 0  norm_wns:  -1.0000
fail_endp: -1
tns:  0  tns_per_endp:  -1.0000   norm_tns_per_endp:  -1.0000
tns_sense_max:  -1.0000  tns_sense_avg:  -1.0000   tns_sense_num: -1
Smallest config area : 41960545.  Fastest config wns;  0
+----------------------------------------------------------------------------------------------------------------------------------------------------------------+
Committed config: CDN_DP_region_0_0_c7
Info    : Done implementing datapath configurations. [DPOPT-4]
: Selected 'very_fast' configuration 7 for module 'CDN_DP_region_0_0'.
Optimizations applied to 'very_fast' configuration:
rewriting(0), factoring(0), sharing(0), cmultcse(0), downsizing(0), speculation(0)
Info    : Done optimizing datapath logic. [DPOPT-2]
: Done optimizing datapath logic in 'counter'.
Number of big hc bmuxes after = 0
Starting logic reduction [v1.0] (stage: post_rtlopt, startdef: counter, recur: true)
Completed logic reduction (accepts: 0, rejects: 0, runtime: 0.000s)
Starting mux data reorder optimization [v1.0] (stage: post_rtlopt, startdef: counter, recur: true)
Completed mux data reorder optimization (accepts: 0, rejects: 0, runtime: 0.000s)
Stage: post_rtlopt
----------------------------------------------------------
| Transform           | Accepts | Rejects | Runtime (ms) |
----------------------------------------------------------
| hlo_logic_reduction |       0 |       0 |         0.00 |
| hlo_mux_reorder     |       0 |       0 |         0.00 |
----------------------------------------------------------
Starting mux speculation [v1.0] (stage: post_muxopt, startdef: counter, recur: true)
Starting speculation optimization
Completed speculation optimization (accepts:0)
Completed mux speculation (accepts: 0, rejects: 0, runtime: 0.001s)
Stage: post_muxopt
------------------------------------------------------
| Transform       | Accepts | Rejects | Runtime (ms) |
------------------------------------------------------
| hlo_speculation |       0 |       0 |         1.00 |
------------------------------------------------------
==================================
Stage : to_generic
==================================
=================
Message Summary
=================
-----------------------------------------------------------------------------------------------------------------------------
|    Id    |Sev  |Count |                                           Message Text                                            |
-----------------------------------------------------------------------------------------------------------------------------
| CDFG-372 |Info |    1 |Bitwidth mismatch in assignment.                                                                   |
|          |     |      |Review and make sure the mismatch is unintentional. Genus can possibly issue bitwidth mismatch     |
|          |     |      | warning for explicit assignments present in RTL as-well-as for implicit assignments inferred by   |
|          |     |      | the tool. For example, in case of enum declaration without value, the tool will implicitly assign |
|          |     |      | value to the enum variables. It also issues the warning for any bitwidth mismatch that appears in |
|          |     |      | this implicit assignment.                                                                         |
| CWD-19   |Info |    9 |An implementation was inferred.                                                                    |
| DPOPT-1  |Info |    1 |Optimizing datapath logic.                                                                         |
| DPOPT-2  |Info |    1 |Done optimizing datapath logic.                                                                    |
| DPOPT-3  |Info |    1 |Implementing datapath configurations.                                                              |
| DPOPT-4  |Info |    1 |Done implementing datapath configurations.                                                         |
| DPOPT-6  |Info |    1 |Pre-processed datapath logic.                                                                      |
| ELAB-1   |Info |    1 |Elaborating Design.                                                                                |
| ELAB-3   |Info |    1 |Done Elaborating Design.                                                                           |
| LBR-41   |Info |    1 |An output library pin lacks a function attribute.                                                  |
|          |     |      |If the remainder of this library cell's semantic checks are successful, it will be considered as a |
|          |     |      | timing-model (because one of its outputs does not have a valid function.                          |
| LBR-155  |Info |  372 |Mismatch in unateness between 'timing_sense' attribute and the function.                           |
|          |     |      |The 'timing_sense' attribute will be respected.                                                    |
| LBR-161  |Info |    1 |Setting the maximum print count of this message to 10 if information_level is less than 9.         |
| LBR-162  |Info |  124 |Both 'pos_unate' and 'neg_unate' timing_sense arcs have been processed.                            |
|          |     |      |Setting the 'timing_sense' to non_unate.                                                           |
| LBR-170  |Info |   32 |Ignoring specified timing sense.                                                                   |
|          |     |      |Timing sense should never be set with 'rising_edge' or 'falling_edge' timing type.                 |
| LBR-412  |Info |    1 |Created nominal operating condition.                                                               |
|          |     |      |The nominal operating condition is represented, either by the nominal PVT values specified in the  |
|          |     |      | library source (via nom_process,nom_voltage and nom_temperature respectively)                     |
|          |     |      | , or by the default PVT values (1.0,1.0,1.0).                                                     |
| LBR-516  |Info |    1 |Missing library level attribute.                                                                   |
| LBR-518  |Info |    1 |Missing a function attribute in the output pin definition.                                         |
| PHYS-752 |Info |    1 |Partition Based Synthesis execution skipped.                                                       |
| SYNTH-1  |Info |    1 |Synthesizing.                                                                                      |
| TIM-1000 |Info |    1 |Multimode clock gating check is disabled.                                                          |
-----------------------------------------------------------------------------------------------------------------------------
Mapper: Libraries have:
domain _default_: 324 combo usable cells and 128 sequential usable cells
Multi-threaded constant propagation [1|0] ...
Multi-threaded Virtual Mapping    (8 threads, 8 of 24 CPUs usable)
==================================
Stage : first_condense
==================================
=================
Message Summary
=================
---------------------------------------------------------------
|  Id  |Sev  |Count |              Message Text               |
---------------------------------------------------------------
| GB-6 |Info |    1 |A datapath component has been ungrouped. |
---------------------------------------------------------------
 
Global mapping target info
==========================
Cost Group 'clk' target slack:   297 ps
Target path end-point (Pin: count_reg[3]/d)
State Retention Synthesis Status
================================
Category                        Flops   Percentage
--------------------------------------------------
Total instances                     4        100.0
Excluded from State Retention       4        100.0
- Will not convert              4        100.0
- Preserved                   0          0.0
- Power intent excluded       4        100.0
- Could not convert             0          0.0
- Scan type                   0          0.0
- No suitable cell            0          0.0
State Retention instances           0          0.0
--------------------------------------------------
PBS_Generic_Opt-Post - Elapsed_Time 1, CPU_Time -0.006171999999999844
stamp 'PBS_Generic_Opt-Post' being created for table 'pbs_debug'
Total Time (Wall) |  Stage Time (Wall)  |   % (Wall)   |    Date - Time     |  Memory   | Stage
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:04(00:00:02) |  00:00:00(00:00:00) |  -0.0(  0.0) |   13:16:43 (Sep17) |  281.1 MB | PBS_Generic-Start
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:03(00:00:03) |  00:00:00(00:00:01) | 100.0(100.0) |   13:16:44 (Sep17) |  281.1 MB | PBS_Generic_Opt-Post
--------------------+---------------------+--------------+--------------------+-----------+----------------------
Number of threads: 8 * 1   (id: pbs_debug, time_info v1.57)
Info: (*N*) indicates data that was populated from previously saved time_info database
Info: CPU time includes time of parent + longest thread
PBS_Generic-Postgen HBO Optimizations - Elapsed_Time 0, CPU_Time 0.0
stamp 'PBS_Generic-Postgen HBO Optimizations' being created for table 'pbs_debug'
Total Time (Wall) |  Stage Time (Wall)  |   % (Wall)   |    Date - Time     |  Memory   | Stage
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:04(00:00:02) |  00:00:00(00:00:00) |  -0.0(  0.0) |   13:16:43 (Sep17) |  281.1 MB | PBS_Generic-Start
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:03(00:00:03) |  00:00:00(00:00:01) | 100.0(100.0) |   13:16:44 (Sep17) |  281.1 MB | PBS_Generic_Opt-Post
--------------------+---------------------+--------------+--------------------+-----------+----------------------
00:00:03(00:00:03) |  00:00:00(00:00:00) |  -0.0(  0.0) |   13:16:44 (Sep17) |  281.1 MB | PBS_Generic-Postgen HBO Optimizations
--------------------+---------------------+--------------+--------------------+-----------+----------------------
Number of threads: 8 * 1   (id: pbs_debug, time_info v1.57)
Info: (*N*) indicates data that was populated from previously saved time_info database
Info: CPU time includes time of parent + longest thread
clear
