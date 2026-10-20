`timescale 1ns / 1ps
`define WIDTH 16

module tb_cm;

  // 测试输入信号
  reg signed [`WIDTH-1:0] x;
  reg [2:0] sel;

  // 输出信号
  wire signed [`WIDTH-1:0] Y0_tb; // 被测模块输出
  wire signed [`WIDTH-1:0] Y1_tb; // 被测模块输出

  // 实例化被测模块（const_multiplier模块）
  const_multiplier u_const_multiplier (
    .x(x),
    .sel(sel),
    .Y0(Y0_tb),
    .Y1(Y1_tb)
  );

  initial begin
    // 生成波形文件
    $dumpfile("u_const_multiplier_simple.vcd");
    $dumpvars(0, u_const_multiplier);

    // 设置测试信号x
    x = 10000; // 设置一个固定的输入值（可以根据需求调整）
    sel = 0;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    sel = 1;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    //x = -10000; // 设置一个固定的输入值（可以根据需求调整）
    sel = 2;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    sel = 3;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    sel = 4;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    sel = 5;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    //x = -10000; // 设置一个固定的输入值（可以根据需求调整）
    sel = 6;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    sel = 7;
    // 对sel值进行循环测试
    #10
    $display("sel = %b, x = %d, Y0 = %d, Y1 = %d", sel, x, Y0_tb, Y1_tb);

    // for (sel = 0; sel < 1 sel = sel + 1) begin
    //   #10; // 等待 10 时间单位
    // end

    $finish;
  end

endmodule