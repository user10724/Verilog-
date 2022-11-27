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
	input [3:0] i_pulse,
    input i_en,
	output [15:0] o_pulse_cnt0,o_pulse_cnt1,o_pulse_cnt2,o_pulse_cnt3
    );



pulse_counter U_PULSE_COUNTER_0(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_pulse                        ( i_pulse[0]                       ),
    .i_en                           ( i_en                          ),
    .o_pulse_cnt                    ( o_pulse_cnt0                   )
);


pulse_counter U_PULSE_COUNTER_1(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_pulse                        ( i_pulse[1]                       ),
    .i_en                           ( i_en                          ),
    .o_pulse_cnt                    ( o_pulse_cnt1                   )
);

pulse_counter U_PULSE_COUNTER_2(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_pulse                        ( i_pulse[2]                       ),
    .i_en                           ( i_en                          ),
    .o_pulse_cnt                    ( o_pulse_cnt2                   )
);

pulse_counter U_PULSE_COUNTER_3(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_pulse                        ( i_pulse[3]                       ),
    .i_en                           ( i_en                          ),
    .o_pulse_cnt                    ( o_pulse_cnt3                   )
);

endmodule

