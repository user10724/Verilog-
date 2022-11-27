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
module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg clk;
reg rst_n;
reg i_pulse;
reg i_en;
wire o_vld;
wire [15:0] o_pulse_cnt;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	


vlg_design U_VLG_DESIGN_0(
    .i_clk                          ( clk                           ),
    .i_rst_n                        ( rst_n                         ),
    .i_pulse                        ( i_pulse                       ),
    .i_en                           ( i_en                          ),
    .o_vld                          ( o_vld                         ),
    .o_pulse_cnt                    ( o_pulse_cnt                   )
);


////////////////////////////////////////////////////////////
//��λ��ʱ�Ӳ���

//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst_n <= 0;
	#1000;
	rst_n <= 1;
end
	
	//ʱ�Ӳ���
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//���Լ�������
//
integer i;

initial begin
    i_pulse <= 1'b0;
    i_en    <= 1'b0;

	@(posedge rst_n);	//�ȴ���λ���
    
    @(posedge clk);
    
    repeat(10) begin
        @(posedge clk);
    end

    #4; 
    i_en    <= 1'b1;

    for(i=0;i<50;i=i+1) begin
        #1000;
        i_pulse <= 1'b1;
        #1000;
        i_pulse <= 1'b0;
    end
    i_en <=1'b0;
    #10_000;

    i_en    <= 1'b1;
    for(i=0;i<69;i=i+1) begin
        #5000;
        i_pulse <= 1'b1;
        #5000;
        i_pulse <= 1'b0;
    end
    i_en <=1'b0;
    #10_000;
    

    i_en    <= 1'b0;
    for(i=0;i<15;i=i+1) begin
        #500;
        i_pulse <= 1'b1;
        #300;
        i_pulse <= 1'b0;
    end
    i_en <=1'b0;
    
    #10000;




	
	
	$stop;
end


endmodule





