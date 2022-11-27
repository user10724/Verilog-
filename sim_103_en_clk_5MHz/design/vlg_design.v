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
	input clk,          //100MHz
	input rst_n,
	
	output reg [3:0] syscnt
    );

localparam DIVCNT_MAX   = 5'd19;
reg [4:0] divcnt;
reg clk_en;


//������ʱ��100MHz ��20��Ƶ
always @(posedge clk or negedge rst_n)	
	if(!rst_n) divcnt <= 'b0;
	else if(divcnt  < DIVCNT_MAX) divcnt <= divcnt + 1'b1;
    else divcnt <= 'b0;
	


//����ʱ��ʹ���źţ����ʱ��ʹ���ź�ÿ��20��������һ��������
always @(posedge clk)
    if(!rst_n) clk_en   <= 1'b0;
    else if(divcnt == DIVCNT_MAX) clk_en <= 1'b1;
    else clk_en <= 1'b0;


//ʹ��ʱ��ʹ���źŽ��м���
always @(posedge clk)
    if(!rst_n) syscnt <= 'b0;
    else if(clk_en) syscnt<= syscnt+1'b1;
    else syscnt <= syscnt;



endmodule

