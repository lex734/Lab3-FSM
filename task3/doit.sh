#!/bin/sh

~/Documents/iac/lab0-devtools/tools/attach_usb.sh
# cleanup
rm -rf obj_dir
rm -f fsm_clktick.vcd

# run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace fsm_clktick.sv  --exe fsm_clktick_tb.cpp

# build C++ project via make automatically geenerated by Verilator
make -j -C obj_dir/ -f Vfsm_clktick.mk   Vfsm_clktick

# run executable simulation file
obj_dir/Vfsm_clktick