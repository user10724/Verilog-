/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 2020.4 
//�����׼��ͺţ� KINTEX7 GENESYS2 
// Author: NJU zhoutao 
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module vlg_design
(
	input i_clk_p, //200MHz    5ns
    input i_clk_n,
    input i_rst_n,
    input i_echo,
    output o_trig

    );

IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(i_clk),  // Buffer output
      .I(i_clk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(i_clk_n) // Diff_n buffer input (connect directly to top-level port)
   );
localparam P_CLK_PERIOD =5    ;

wire w_clk_en;
wire [15:0] w_t_us;
wire [13:0] o_s_mm;
//////////////////////////////////
//ʹ��ʱ�Ӳ���ģ��

vlg_en #(
    .P_CLK_PERIOD                   (  P_CLK_PERIOD                         ))
U_VLG_EN_0(
    .i_clk                          ( i_clk                        ),
    .i_rst_n                        ( i_rst_n                       ),
    .o_clk_en                       ( w_clk_en                      )
);
/////////////////////////////////////
//�������������ģ��Ĵ����ź�o_trig

vlg_trig U_VLG_TRIG_0(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_clk_en                       ( w_clk_en                      ),
    .o_trig                         ( o_trig                        )
);

////////////////////////////////////////////
//���������ģ��Ļ����ź�i_echo �ĸߵ�ƽʱ��ɼ�

vlg_echo U_VLG_ECHO_0(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_clk_en                       ( w_clk_en                      ),
    .i_echo                         ( i_echo                        ),
    .o_t_us                         ( w_t_us                        )
);

//////////////////////////////////////////
//����ʱ��;����ת������s =0.179t


vlg_cal U_VLG_CAL_0(
    .i_clk                          ( i_clk                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_t_us                         ( w_t_us                        ),
    .o_s_mm                         ( o_s_mm                        )
);


debug_vio u_debug_vio (
  .clk(i_clk),              // input wire clk
  .probe_in0(o_s_mm)  // input wire [13 : 0] probe_in0
);
endmodule
