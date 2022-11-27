/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 2020.4 
//�����׼��ͺţ� KINTEX7 GENESYS2 
// Author: NJU zhoutao 
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module vlg_cal
(
	input i_clk, //200MHz    5ns
    input i_rst_n,
    input [15:0] i_t_us,
    output [13:0]  o_s_mm
    );

// s=0.173*t
// S*4096=0.173*4096
// S*4096=709*t;
//  S=709*t>>12
//  
//  ����1ֱ��ʹ��IP��   xilinx ֧��ֱ�ӳ˺ţ�ʹ��ר�ó˷����� �����Ƽ�IP�� ��ѡ�����Ż����ã�
//  ʹ���ܸ���
//  ����2  709 =512+128+64+4+1=2^9+2^7+2^6+2^2+2^0

//////////////////////////////
//�˷��� ip����

wire [25:0] w_mult_result;

mult_gen_0 u_mult (
  .CLK(i_clk),  // input wire CLK
  .A(10'd709),      // input wire [9 : 0] A
  .B(i_t_us),      // input wire [15 : 0] B
  .P(w_mult_result)      // output wire [25 : 0] P
);
//����12λ ����ֻ��Ҫ��14λ
assign o_s_mm = w_mult_result[25:12];




    
endmodule

