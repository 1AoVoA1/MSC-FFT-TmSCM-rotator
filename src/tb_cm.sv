`timescale 1ns / 1ps
`define WIDTH 16

module tb_cm;

  // 测试输入信号
  reg signed [`WIDTH-1:0] x;
  reg [0:0] sel;

  // 输出信号
  wire signed [15:0] Y0_tb, Y1_tb; // 被测模块输出

  integer file;
  integer i, j;
  integer error_Y0, error_Y1;
  integer test_count;
  real sum_sq_Y0, sum_sq_Y1;
  real RMSE_Y0, RMSE_Y1;

  reg signed [15:0] Y0_ref, Y1_ref;

  // 实例化被测模块
  TW10 u_TW10 (
    .x(x),
    .sel(sel),
    .Y0(Y0_tb)
  );

  // TW11_real u_TW11 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // TW11_imag u_TW11 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );

  // TW12_real u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // TW12_imag u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );

  // TW13_real u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // TW13_imag u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );

  // TW22_real u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // TW22_imag u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );

  // TW23_real u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // TW23_imag u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );

  // TW32_real u_TW12and13 (
  //   .x(x),
  //   .sel(sel),
  //   .Y0(Y0_tb)
  // );
  // 预定义定点量化系数（16-bit）
  integer TW10;
  integer TW11_9239, TW11_3827;
  integer TW12_9808, TW12_5556, TW12_1951, TW12_8315;


  // 量化系数 (乘以 2^10)
  integer SCALE;
  initial begin
      SCALE = 1024; // 2^10
  end
  // 计算量化后的参考值 (直接截断)
  function signed [15:0] expected_value;
    input signed [`WIDTH-1:0] x_val;
    input integer coeff_fixed;
    integer res;
    begin
      res = (x_val * coeff_fixed) >>> 10; // 直接截断
      expected_value = res[15:0]; // 取低 16 位
    end
  endfunction

  initial begin
    // 初始化量化后的系数
    
    // TW10
    TW10 = 0.7071  * SCALE;
    
    // TW11
    TW11_9239 = 0.9239  * SCALE;
    TW11_3827 = 0.3827  * SCALE;

    // TW12and13
    TW12_9808 = 0.9808  * SCALE;
    TW12_5556 = 0.5556  * SCALE;
    TW12_1951 = 0.1951  * SCALE;
    TW12_8315 = 0.8315  * SCALE;
  
  end

  initial begin
    sum_sq_Y0 = 0.0;
    sum_sq_Y1 = 0.0;
    test_count = 0;

    // 生成波形文件
    $dumpfile("u_TW10.vcd");
    $dumpvars(0, u_TW10);

    // 打开文件
    file = $fopen("u_TW10.txt", "w");
    if (file == 0) begin
      $display("Failed to open file for writing.");
      $finish;
    end

    // $fwrite(file, "Time\t SEL\t X\t Y0_tb\t Y0_ref\t Error_Y0\t Y1_tb\t Y1_ref\t Error_Y1\n");

    // $monitor("Time: %0t | sel: %b | x: %d | Y0_tb: %d | Y1_tb: %d", $time, sel, x, Y0_tb, Y1_tb);

    x = 10000;
    sel = 0;
    #10;

    // sel = 0, sel = 1 循环测试
    for (j = 0; j < 1; j = j + 1) begin
      sum_sq_Y0 = 0;
      error_Y1 = 0;
      test_count = 0;
      for (i = 0; i < 1000; i = i + 1) begin
        x = $random % (1 << (`WIDTH-1)) - (1 << (`WIDTH - 2)); // 生成 [-32768, 32767] 范围的随机数
        x = $random >>> 18; 
        #10;

        // 计算参考值（量化后）
        if (sel == 0) begin
            Y0_ref = expected_value(x, TW10);
        end
        else if (sel == 1) begin
            Y0_ref = expected_value(x, -TW10);
        end
        else if (sel == 2) begin
            Y0_ref = expected_value(x, -TW12_5556);
        end
        else if (sel == 3) begin
            Y0_ref = expected_value(x, -TW12_9808);
        end

        // 计算误差
        error_Y0 = Y0_tb - Y0_ref;
        sum_sq_Y0 = sum_sq_Y0 + (error_Y0 * error_Y0);
        test_count = test_count + 1;

        $fwrite(file, "%0t\t %b\t %d\t %d\t %d\t %d \n", 
                        $time, sel, x, Y0_tb, Y0_ref, error_Y0);
      end

        // 计算 RMSE（基于整数误差计算）
        RMSE_Y0 = $sqrt(sum_sq_Y0 / test_count);

        // 记录 RMSE
        $fwrite(file, "\nSum of Squared Errors (Y0) = %f\n", sum_sq_Y0);
        $fwrite(file, "Number of Tests = %d\n", test_count);
        $fwrite(file, "RMSE (Y0) = %f\n", RMSE_Y0);

        // 显示 RMSE
        $display("RMSE (Y0): %f", RMSE_Y0);

        sel = sel + 1;
      end

    #100;
    $fclose(file);
    $finish;
  end

endmodule