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
    input i_en,
    output o_vld,
	output [15:0] o_pulse_cnt
    );

reg[1:0] r_pulse;
wire w_rise_edge;

/////////////////////////////////
//������ؼ���߼�
always @(posedge i_clk )	
	if(!i_rst_n) r_pulse <= 2'b00;
	else r_pulse <= {r_pulse[0],i_pulse};
    //  r_pulse[0] <= i_pulse;   //�ȼ�
    //  r_pulse[1] <= r_pulse[0];
    //
    //


	
assign w_rise_edge = r_pulse[0] & ~r_pulse[1];

//////////////////////////////////
// ����źŲ���
reg r_flag;

always @(posedge i_clk)
    if(!i_rst_n) r_flag <= 'b0;
    else if(!i_en) r_flag <= 'b0;
    else if(w_rise_edge) r_flag <= 'b1;
    else ;

assign o_vld = w_rise_edge & r_flag;

////////////////////////////////
//��������߼�
//

reg [15:0] r_pulse_cnt;

always @(posedge i_clk)
    if(!i_en) r_pulse_cnt <= 'b0;
    else if(w_rise_edge)  r_pulse_cnt<= 'b0;
    else r_pulse_cnt <= r_pulse_cnt+1'b1;

assign o_pulse_cnt =r_pulse_cnt +1'b1;

endmodule

