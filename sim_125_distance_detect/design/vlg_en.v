/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 2020.4 
//�����׼��ͺţ� KINTEX7 GENESYS2 
// Author: NJU zhoutao 
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module vlg_en #(
    parameter P_CLK_PERIOD =5          //i_clk ʱ������Ϊ 5ns
)
(
	input i_clk, //200MHz    5ns
    input i_rst_n,
    output reg o_clk_en
    );

localparam P_DIVCLK_MAX     = (1000/P_CLK_PERIOD)-1;  //��Ƶ���������ֵ
reg [7:0]   r_divcnt;

//////////////////////////////
//������ʱ�� i_clk

always @(posedge i_clk)
    if(!i_rst_n) r_divcnt <=0;
    else if(r_divcnt <P_DIVCLK_MAX) 
        r_divcnt <= r_divcnt +1;
    else r_divcnt <= 'b0;
    
////////////////////////////////////
//����ʱ��ʹ���ź�

always @(posedge i_clk)
    if(r_divcnt == P_DIVCLK_MAX) o_clk_en <= 1'b1;
    else o_clk_en <= 1'b0;
    
endmodule

