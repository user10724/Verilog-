
/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 20.4 
//�����׼��ͺţ� kintex7 genesys2
//����: NJU zhoutao
/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		5.0		//ʱ����������Ϊ5ns��200MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg i_clk_p;
reg i_clk_n;
reg i_rst_n;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	

vlg_design U_VLG_DESIGN_0(
    .i_clk_p                        ( i_clk_p                       ),
    .i_clk_n                        ( i_clk_n                       ),
    .i_rst_n                        ( i_rst_n                       )
);


////////////////////////////////////////////////////////////
//��λ��ʱ�Ӳ���

//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	i_clk_p <= 0;
    i_clk_n <= 1;
	i_rst_n <= 0;
	#1000;
	i_rst_n <= 1;
end
	
	//ʱ�Ӳ���
always #(`CLK_PERIORD/2) i_clk_p <= ~i_clk_p;	

always #(`CLK_PERIORD/2) i_clk_n <= ~i_clk_n;
////////////////////////////////////////////////////////////
//���Լ�������

initial begin

	@(posedge i_rst_n);	//�ȴ���λ���
    
    @(posedge i_clk_p);

    
    
    repeat(20*16*2) begin
        @(posedge i_clk_p);
    end


	
	
	$stop;
end


endmodule






