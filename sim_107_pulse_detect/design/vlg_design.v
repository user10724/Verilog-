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
	input i_clk,
	input i_rst_n,
	input i_pulse,
	output o_rise_edge
    );

reg[1:0] r_pulse;
wire r_pulse1_invert;



always @(posedge i_clk )	
	if(!i_rst_n) r_pulse <= 2'b00;
	else r_pulse <= {r_pulse[0],i_pulse};
    //  r_pulse[0] <= i_pulse;   //�ȼ�
    //  r_pulse[1] <= r_pulse[0];
    //
    //

assign r_pulse1_invert = ~r_pulse[1];
	
assign o_rise_edge = r_pulse[0] & r_pulse1_invert;


endmodule
