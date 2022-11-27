/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2019.1 + ModelSim SE-64 10.5 
//�����׼��ͺţ� STAR ����FPGA�����׼�
//��   Ȩ  ��   ���� �������ɡ�����ǳ����תFPGA�����ߡ���Ȩͬѧ��ԭ����
//				������Ȩͬѧ���FPGA�����׼�ѧϰʹ�ã�лл֧��
//�ٷ��Ա����̣� http://myfpga.taobao.com/
//΢ �� �� �� �ţ���FPGA����ѧϰ��
//				��ӭ��ע����ȡ������µ�FPGAѧϰ���� 
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module vlg_design(
	input clk_n,            //200MHz    5ns
	input clk_p,
    input i_rst_n,
    input i_en,
	input [9:0] i_data,
    output o_vld,
	output [15:0] o_sin
    );


localparam TIMER_1S_MAX_CNT = 32'd1_000_000_000/5;

wire i_clk;
IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(i_clk),  // Buffer output
      .I(clk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(clk_n) // Diff_n buffer input (connect directly to top-level port)
   );

reg[1:0] r_vld;

always @(posedge i_clk)
    if(!i_rst_n) r_vld <= 2'b00;
    else r_vld <= {r_vld[0],i_en};

assign o_vld = r_vld[1]; 

blk_mem_gen_0 u_sin_rom (
  .clka(i_clk), //    // input wire clka
  .addra(i_data),  // input wire [9 : 0] addra
  .douta(o_sin)  // output wire [15 : 0] douta
);

endmodule

