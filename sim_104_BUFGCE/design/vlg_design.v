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
   // input en,
    output outclk
    );

`define SIMULATION
    //������ⲿʹ���ź�
//reg enr;

//always @(posedge clk)
  //  if(!rst_n) enr <='b0;
    //else enr <= en;
#`ifdef SIMULATION

localparam TIMER_CNT_1S = 30'd1_000 -1'b1;  //1s�������ֵ
localparam TIMER_CNT_10MS = 30'd10 -1'b1;  //10ms�������ֵ
`else

localparam TIMER_CNT_1S = 30'd100_000_000 -1'b1;  //1s�������ֵ
localparam TIMER_CNT_10MS = 30'd1_000_000 -1'b1;  //10ms�������ֵ

`endif    
// 1s���ڼ���
reg [29:0]  cnt;

always @(posedge clk)
    if(!rst_n) cnt <='b0;
    else if(cnt < TIMER_CNT_1S)cnt <= cnt +1'b1;
    else cnt <= 'b0;


//10ms ʹ���źŲ���
reg en_10ms;

always @(posedge clk)
    if(!rst_n) en_10ms <='b0;
    else if(cnt <= TIMER_CNT_10MS) en_10ms <=1'b1;	
    else en_10ms <= 'b0;

//����ԭ��

   BUFGCE BUFGCE_inst (
      .O(outclk),   // 1-bit output: Clock output
      .CE(en_10ms), // 1-bit input: Clock enable input for I0
      .I(clk)    // 1-bit input: Primary clock
  );
endmodule

