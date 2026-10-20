// `define WIDTH 16

// module TW23_real(
//   input wire signed [`WIDTH-1:0] x,
//   input wire [0:0] sel,
//   output wire signed [15:0] Y0
// );

// wire signed [23:0] y0;
// wire signed [15:0] v0;
// assign v0 = x ;
// wire signed [18:0] v1;
// wire signed [18:0] a_input_1;
// wire signed [18:0] b_input_1;
// wire signed [21:0] v2;
// wire signed [21:0] a_input_2;
// wire signed [21:0] b_input_2;
// wire signed [23:0] v3;
// wire signed [23:0] a_input_3;
// wire signed [23:0] b_input_3;

// // v1 的左输入
// assign a_input_1 = v0 <<< 0;

// // v1 的右输入
// assign b_input_1 = - (v0 <<< 3);

// // 计算 v1
// assign v1 = b_input_1 + a_input_1;

// // v2 的左输入
// assign a_input_2 = - (v1 <<< 3);

// // v2 的右输入
// assign b_input_2 = sel == 1 ? v0 <<< 6 : v1 <<< 0;

// // 计算 v2
// assign v2 = a_input_2 + b_input_2;

// // v3 的左输入
// assign a_input_3 = v1 <<< 0;

// // v3 的右输入
// assign b_input_3 = v2 <<< 2;

// // 计算 v3
// assign v3 = b_input_3 + a_input_3;

// // 选择输出节点
// assign y0 = (sel == 1) ? -(v3 >>> 9) : (v2 >>> 7);
// assign Y0 = y0;
// endmodule
// TW11_0 = 0.9238
// TW11_1 = 0.3828
// -----------------------------TW11 实部-----------------------------
`define WIDTH 16

module TW23_imag(
  input wire signed [`WIDTH-1:0] x,
  input wire [0:0] sel,
  output wire signed [15:0] Y0
);

wire signed [23:0] y0;
wire signed [15:0] v0;
assign v0 = x ;
wire signed [18:0] v1;
wire signed [18:0] a_input_1;
wire signed [18:0] b_input_1;
wire signed [21:0] v2;
wire signed [21:0] a_input_2;
wire signed [21:0] b_input_2;
wire signed [23:0] v3;
wire signed [23:0] a_input_3;
wire signed [23:0] b_input_3;

// v1 的左输入
assign a_input_1 = v0 <<< 0;

// v1 的右输入
assign b_input_1 = - (v0 <<< 3);

// 计算 v1
assign v1 = b_input_1 + a_input_1;

// v2 的左输入
assign a_input_2 = - (v1 <<< 3);

// v2 的右输入
assign b_input_2 = sel == 1 ? v1 <<< 0 : v0 <<< 6;

// 计算 v2
assign v2 = a_input_2 + b_input_2;

// v3 的左输入
assign a_input_3 = v1 <<< 0;

// v3 的右输入
assign b_input_3 = v2 <<< 2;

// 计算 v3
assign v3 = b_input_3 + a_input_3;

// 选择输出节点
assign y0 = (sel == 1) ? -(v2 >>> 7) : -(v3 >>> 9);
assign Y0 = y0;
endmodule