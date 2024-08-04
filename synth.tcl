set search_path {}

set link_library {}

set target_library {}

analyze -library work -format verilog -top top_module -autoread {}

elaborate top_module -library work
link

source {}

compile_ultra

report_timing > {}
report_power > {}
report_qor > {}
report_area -hierarchy > {}

write -format verilog -hierarchy -output {}

