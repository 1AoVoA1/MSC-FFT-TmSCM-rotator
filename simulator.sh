# yosys VerilogSyns.ys

# dot -Tpng adder_rtl.dot -o OutputFile.png

rm -rf testbench.out

iverilog -o testbench.out src/tb_cm.sv src/TW10.sv
vvp testbench.out

