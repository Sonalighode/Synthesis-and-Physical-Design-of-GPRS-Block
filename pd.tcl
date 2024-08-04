set search_path {/home/tools/libraries/lib/stdcell_hvt/db_nldm\
/home/tools/libraries/lib/stdcell_lvt/db_nldm\
/home/tools/libraries/lib/stdcell_rvt/db_nidm\
/home/tools/libraries/lib/sram_lp_new/db_nidm\
/home/visiguru/PHYSICAL_DESIGN/TRAINER1/ICC2/ORCA_TOP/ref/CLIBs\
/home/tools/libraries/tech/star_rcxt\
/home/tools/libraries/tech/milkyway\
}

set link_library {saed32hvt_ss0p95v125c.db saed32rvt_ss0p95v125c.db saed32sramlp_ss0p95v125c_i0p95v.db}
set target_library {saed32hvt_ss0p95v125c.db saed32rvt_ss0p95v125c.db saed32sramlp_ss0p95v125c_i0p95v.db}

set ndm_ref_libs {saed32_hvt.ndm saed32_lvt.ndm saed32_rvt.ndm saed32_sram_lp.ndm}
create_lib -ref_libs $ndm_ref_libs -out_dir ./outputs/work -lib ChipTop.nlib
save_lib

read_verilog ./inputs/ChipTop_netlist.v

read_parasitic_tech -tluplus saed32nm_1p9m_Cmax.tluplus -layermap saed32nm_tf_itf_tluplus.map -name Cmax
read_parasitic_tech -tluplus saed32nm_1p9m_Cmin.tluplus -layermap saed32nm_tf_itf_tluplus.map -name Cmin
set_parasitic_parameters -early_spec Cmax -late_spec Cmin

source ./inputs/chiptop.sdc

set_attribute [get_layers {M1 M3 M5 M7 M9}] -routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] -routing_direction vertical

initialize_floorplan -core_utilization 0.7 -core_offset {5 5 5 5} -site_def unit -use_site_row

set_block_pin_constraints -allowed_layers {M5 M6}
place_pins -ports [get_ports]

set_app_options -name plan.macro.macro_place_only -value true
set_app_options -name plan.macro.grouping_by_hierarchy -value true
set_app_options -name plan.macro.spacing_rule_heights -value {10u 10u}
set_app_options -name plan.macro.spacing_rule_widths -value {10u 10u}
create_placement -floorplan

create_keepout_margin -type hard -outer {1 1 1 1} [get_flat_cells -filter "is_hard_macro"]

remove_all_pattern_strategies_via_rules_and_pg_routes
remove_pg_via_master_rules -all
remove_pg_patterns -all
remove_pg_strategies -all
remove_pg_strategy_via_rules -all
remove_routes -ring -lib_cell_pin_connect -macro_pin_connect -stripe
set all_macros [get_cells -hierarchical -filter "is_hard_macro"]

create_pg_mesh_pattern P_top_two -layers {{{horizontal_layer: M7} {width: 1.104} {spacing: interleaving} {pitch: 13.376} {offset: 0.856} {trim: true}} {{vertical_layer: M8} {width: 4.64} {spacing: interleaving} {pitch: 19.456} {offset: 6.08} {trim: true}}} -via_rule {{intersection: adjacent} {via_master: pgvia_8x10}}
set_pg_strategy S_default_vddvss -core -pattern {{name: P_top_two} {nets: {VSS VDD}}} -offset_start {0 0} -extension {{stop: design_boundary_and_generate_pin}}

create_pg_mesh_pattern P_m2_triple -layers {{{vertical_layer: M2} {track_alignment: track} {width: 0.44 0.192 0.192} {spacing: 2.724 3.456} {pitch: 9.728} {offset: 1.216} {trim: true}}}
set_pg_strategy S_m2_vddvss -core -pattern {{name: P_m2_triple} {nets: {VDD VSS VSS}}} -offset_start {0 0} -blockage {{macros_with_keepout: $all_macros}}
set_pg_strategy_via_rule S_via_m2_m7 -via_rule {{{strategies: {S_m2_vddvss}} {layers: {M2}} {nets: {VDD}}} {{strategies: {S_default_vddvss}} {layers: {M7}} {via_master: default}}} {{{strategies: {S_m2_vddvss}} {layers: {M2}} {nets: {VSS}}} {{strategies: {S_default_vddvss}} {layers: {M7}} {via_master: default}}}
compile_pg_strategies {S_default_vddvss S_m2_vddvss} -via_rule S_via_m2_m7

create_pg_ring_pattern P_HM_ring -horizontal_layer M5 -horizontal_width {0.5} -vertical_layer M6 -vertical_width {0.5} -corner_bridge false
set_pg_strategy S_HM_ring_top -macros $all_macros -pattern {{pattern: P_HM_ring} {nets: {VSS VDD}}} -offset {0.3 0.3}
set_pg_strategy_via_rule S_ring_vias -via_rule {{{strategies: {S_HM_ring_top}} {layers: {M5}} {existing: strap} {via_master: default}} {{{strategies: {S_HM_ring_top}} {layers: {M6}} {existing: strap} {via_master: default}}}
compile_pg_strategies {S_HM_ring_top} -via_rule S_ring_vias

create_pg_macro_conn_pattern P_HM_pin -pin_conn_type scattered_pin -layers {M5 M6}
set_pg_strategy S_HM_top_pins -macros $all_macros -pattern {{pattern: P_HM_pin} {nets: {VSS VDD}}}
compile_pg_strategies {S_HM_top_pins}

create_pg_std_cell_conn_pattern P_std_cell_rail
set_pg_strategy S_std_cell_rail_VSS_VDD -core -blockage {{macros_with_keepout: $all_macros}} -pattern {{pattern: P_std_cell_rail} {nets: {VSS VDD}}}
set_pg_strategy_via_rule S_via_stdcellrail -via_rule {{intersection: all} {via_master: default}}
compile_pg_strategies {S_std_cell_rail_VSS_VDD} -via_rule S_via_stdcellrail

save_block -as floorplan_done

cd chip_top_gps_pd
open_lib ./outputs/works/ChipTop.nlib/

create_block placement_and_cts
copy_block -from block floorplan_done -to block placement_and_cts -force
open_block placement_and_cts

set_fixed_objects [get_flat_cells -filter "is_hard_macro"]
set_app_options -name place.coarse.continue_on_missing_scandef -value true

set_attribute [get_lib_cells TIEH_HVT] -dont_touch false
set_attribute [get_lib_cells TIEH_HVT] -dont_use false

set_app_options -name place.coarse.max_density -value 0.7
set_app_options -name opt.common.max_fanout -value 20

set_ignored_layers -min_routing_layer M2 -max_routing_layer M6
set_app_options -name route.common.net_max_layer_mode -value hard
set_app_options -name route.common.net_min_layer_mode -value allow_pin_connection

set_app_options -name place.legalize.enable_advanced_legalizer -value true
set_app_options -name place.legalize.legalizer_search_and_repair -value true

create_placement
legalize_placement
place_opt -from initial_drc

report_congestion -rerun_global_router

refine_placement
legalize_placement

report_global_timing
report_timing

set_driving_cell -lib_cell NBUFFX8_RVT [get_ports clock]
set_clock_tree_options -target_skew 0.05
set_max_transition 0.2 -clock_path [get_clocks]
set_lib_cell_purpose -include cts "/NBUFF*RVT */INVX_RVT"

clock_opt

report_global_timing

save_block

