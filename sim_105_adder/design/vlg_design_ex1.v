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
module vlg_design_ex1(
	input i_clk,
	input i_rst_n,
	output [3:0]    o_cnt1,o_cnt2
    );


reg [3:0]   r_cnt1,r_cnt2;

always @(posedge i_clk)
    if(!i_rst_n) r_cnt1 <='b0;
    else r_cnt1 <= r_cnt1+1'b1;


always @(posedge i_clk)
    if(!i_rst_n) r_cnt2 <='b0;
    else r_cnt2 <= r_cnt2+1'b1;

assign o_cnt1 = r_cnt1;
assign o_cnt2 = r_cnt2;
	

endmodule

