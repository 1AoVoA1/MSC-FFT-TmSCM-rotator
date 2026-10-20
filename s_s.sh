# yosys VerilogSyns.ys

# dot -Tpng adder_rtl.dot -o OutputFile.png

rm -rf testbench.out

iverilog -o testbench.out src/tb_cm_simple.sv src/const_multiplier.sv
vvp testbench.out

