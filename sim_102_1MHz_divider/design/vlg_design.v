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
	input clk,
	input rst_n,
	output reg clk_1mhz
    );

`define CNT_MAX  100

`define CNT_MAX_DIV2 `CNT_MAX/2
   // localparam CNT_MAX = 8'd100;
   // localparam CNT_MAX_DIV2= 8'd50;

    reg [7:0]   cnt;

    always @(posedge clk)
        if(!rst_n) cnt<= 8'd0;
        else if(cnt < (`CNT_MAX -1)) cnt <= cnt+1'b1;
        else cnt<=  8'd0;

    always @(posedge clk)
        if(!rst_n) clk_1mhz <=1'd0;
        else if(cnt < `CNT_MAX_DIV2) clk_1mhz <=1'b1;
        else clk_1mhz<=1'b0;

	

endmodule

