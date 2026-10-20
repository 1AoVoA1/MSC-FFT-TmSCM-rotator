// TW12_0 = 0.9808
// TW12_1 = 0.5556
// TW12_2 = 0.1951
// TW12_3 = 0.8315
// // -----------------------------TW13 实部-----------------------------
`define WIDTH 16

module TW13_real(
  input wire signed [`WIDTH-1:0] x,
  input wire [1:0] sel,
  output wire signed [15:0] Y0
);

wire signed [25:0] y0;
wire signed [15:0] v0;
assign v0 = x ;
wire signed [18:0] v1;
wire signed [18:0] a_input_1;
wire signed [18:0] b_input_1;
wire signed [20:0] v2;
wire signed [20:0] a_input_2;
wire signed [20:0] b_input_2;
wire signed [25:0] v3;
wire signed [25:0] a_input_3;
wire signed [25:0] b_input_3;
wire signed [25:0] v4;
wire signed [25:0] a_input_4;
wire signed [25:0] b_input_4;

// v1 的左输入
assign a_input_1 = sel == 3 ? 0 : (sel == 2 ? v0 <<< 0 : (sel == 1 ? v0 <<< 1 :  v0 <<< 0  ));

// v1 的右输入
assign b_input_1 = v0 <<< 3;

// 计算 v1
assign v1 = b_input_1 + a_input_1;

// v2 的左输入
assign a_input_2 = sel == 3 ? v1 <<< 0 : (sel == 2 ? -(v0 <<< 3) : (sel == 1 ? v1 <<< 0 : v0 <<< 4));

// v2 的右输入
assign b_input_2 = v1 <<< 2;

// 计算 v2
assign v2 = b_input_2 + a_input_2;

// v3 的左输入
assign a_input_3 = - (v2 <<< 0);

// v3 的右输入
assign b_input_3 = v1 <<< 8;

// 计算 v3
assign v3 = b_input_3 + a_input_3;

// v4 的左输入
assign a_input_4 = v1 <<< 7;

// v4 的右输入
assign b_input_4 = v3 <<< 0;

// 计算 v4
assign v4 = b_input_4 + a_input_4;

// 选择输出节点
assign y0 = (sel == 2'd0) ? (v4 >>> 12) : (sel == 2'd1) ? (v2 >>> 8) : (sel == 2'd2) ? -(v3 >>> 12) : (sel == 2'd3) ? -(v3 >>> 11) : 0;
assign Y0 = y0;
endmodule

// -----------------------------TW13 虚部-----------------------------
// `define WIDTH 16

// module TW13_imag(
//   input wire signed [`WIDTH-1:0] x,
//   input wire [1:0] sel,
//   output wire signed [15:0] Y0
// );

// wire signed [25:0] y0;
// wire signed [15:0] v0;
// assign v0 = x ;
// wire signed [18:0] v1;
// wire signed [18:0] a_input_1;
// wire signed [18:0] b_input_1;
// wire signed [20:0] v2;
// wire signed [20:0] a_input_2;
// wire signed [20:0] b_input_2;
// wire signed [25:0] v3;
// wire signed [25:0] a_input_3;
// wire signed [25:0] b_input_3;
// wire signed [25:0] v4;
// wire signed [25:0] a_input_4;
// wire signed [25:0] b_input_4;

// // v1 的左输入
// assign a_input_1 = sel == 3 ? v0 <<< 1 : (sel == 2 ? v0 <<< 0 : (sel == 1 ? 0 :  v0 <<< 0 ));

// // v1 的右输入
// assign b_input_1 = v0 <<< 3;

// // 计算 v1
// assign v1 = b_input_1 + a_input_1;

// // v2 的左输入
// assign a_input_2 = sel == 3 ? v1 <<< 0 : (sel == 2 ? v0 <<< 4 : (sel == 1 ? v1 <<< 0 : -(v0 <<< 3)));

// // v2 的右输入
// assign b_input_2 = v1 <<< 2;

// // 计算 v2
// assign v2 = b_input_2 + a_input_2;

// // v3 的左输入
// assign a_input_3 = - (v2 <<< 0);

// // v3 的右输入
// assign b_input_3 = v1 <<< 8;

// // 计算 v3
// assign v3 = b_input_3 + a_input_3;

// // v4 的左输入
// assign a_input_4 = v1 <<< 7;

// // v4 的右输入
// assign b_input_4 = v3 <<< 0;

// // 计算 v4
// assign v4 = b_input_4 + a_input_4;

// // 选择输出节点
// assign y0 = (sel == 2'd0) ? -(v3 >>> 12) : (sel == 2'd1) ? -(v3 >>> 11) : (sel == 2'd2) ? -(v4 >>> 12) : (sel == 2'd3) ? -(v2 >>> 8) : 0;
// assign Y0 = y0;
// endmodule
