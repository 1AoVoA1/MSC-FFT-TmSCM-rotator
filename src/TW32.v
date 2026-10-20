//    TW10 = 0.7071
`define WIDTH 16

module TW32_real(
  input wire signed [`WIDTH-1:0] x,
  input wire [1:0] sel,
  output wire signed [15:0] Y0
);

wire signed [22:0] y0;
wire signed [15:0] v0;
assign v0 = x ;
wire signed [17:0] v1;
wire signed [17:0] a_input_1;
wire signed [17:0] b_input_1;
wire signed [18:0] v2;
wire signed [18:0] a_input_2;
wire signed [18:0] b_input_2;
wire signed [22:0] v3;
wire signed [22:0] a_input_3;
wire signed [22:0] b_input_3;

// v1 的左输入
assign a_input_1 = v0 <<< 0;

// v1 的右输入
assign b_input_1 = v0 <<< 2;

// 计算 v1
assign v1 = b_input_1 + a_input_1;

// v2 的左输入
assign a_input_2 = v0 <<< 0;

// v2 的右输入
assign b_input_2 = v1 <<< 1;

// 计算 v2
assign v2 = b_input_2 + a_input_2;

// v3 的左输入
assign a_input_3 = v1 <<< 0;

// v3 的右输入
assign b_input_3 = v2 <<< 4;

// 计算 v3
assign v3 = b_input_3 + a_input_3;

// 选择输出节点
assign y0 = v3 >>> 8;
assign Y0 = y0;
endmodule
