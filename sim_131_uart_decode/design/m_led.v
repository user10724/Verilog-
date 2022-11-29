/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 2020.4 
//�����׼��ͺţ� KINTEX7 GENESYS2 
// Author: NJU zhoutao 
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module m_led(
	input i_clk_p, //200MHz    5ns
    //input i_clk_n,
	input i_rst_n,
    input i_en,
    input [31:0]    i_period,       //���ڣ� ��λ5ns
    input [31:0]    i_high,         //�ߵ�ƽʱ��    ��λ5ns
    input [15:0]    i_times,        //����          
    output reg o_pwm

    );
    /*
IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(i_clk),  // Buffer output
      .I(i_clk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(i_clk_n) // Diff_n buffer input (connect directly to top-level port)
   );

*/


reg[1:0]    r_en;
wire    w_pos_en;
wire    w_end_en;
reg    r_cnt_en;   //�ڲ�����������������ʹ���ź�
reg [31:0]  r_pcnt;     //���ڼ�����
reg [31:0]  r_tcnt;     //���ڴ���������

/*
////////////////////////////////////
//VIO ����
wire    i_en;
wire [31:0] i_period;
wire [31:0] i_high;
wire [15:0] i_times;


debug_vio u_debug_vio (
  .clk(i_clk),                // input wire clk
  .probe_out0(i_en),  // output wire [0 : 0] probe_out0
  .probe_out1(i_period),  // output wire [31 : 0] probe_out1
  .probe_out2(i_high),  // output wire [31 : 0] probe_out2
  .probe_out3(i_times)  // output wire [15 : 0] probe_out3
);
*/
///////////////////////////////
//����i_en �������ر�־�ź�

always @(posedge i_clk_p)
    r_en <={r_en[0],i_en};

assign w_pos_en =~r_en[1] & r_en[0];

//////////////////////////////
// w_end_en

assign w_end_en = (r_pcnt == (i_period-1)) &&(r_tcnt ==(i_times-1));

///////////////////////////////////
//�ڲ�����������������ʹ���ź�
always @(posedge i_clk_p)
    if(!i_rst_n) r_cnt_en <= 1'b0;
    else if(w_pos_en) r_cnt_en <= 1'b1;
    else if(w_end_en) r_cnt_en <= 1'b0;
    else ;

////////////////////////////
//���ڼ���

always @(posedge i_clk_p)
    if(!r_cnt_en) r_pcnt <= 'b0;
    else if(r_pcnt < (i_period-1)) r_pcnt <= r_pcnt+1;
    else r_pcnt <='b0;

///////////////////////////////
//���ڴ�������

always @(posedge i_clk_p)
    if(!r_cnt_en) r_tcnt <= 'b0;
    else if(r_pcnt == (i_period-1)) r_tcnt <= r_tcnt+1;
    else ;
///////////////////////////////
//���PWM����    

always @(posedge i_clk_p)
    if((r_pcnt >32'd0)&&(r_pcnt <= i_high)) o_pwm <=1'b1;
    else o_pwm <= 1'b0;


endmodule

