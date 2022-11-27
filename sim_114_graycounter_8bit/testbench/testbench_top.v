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
reg i_en;
reg [7:0] i_data;
wire o_vld;
wire [7:0] o_gray;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
vlg_design U_VLG_DESIGN_0(
    .clk_n                          ( i_clk_n                         ),
    .clk_p                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_en                           ( i_en                          ),
    .i_data                         ( i_data                        ),
    .o_vld                          ( o_vld                         ),
    .o_gray                         ( o_gray                        )
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
integer i;
initial begin
    i_en <= 'b0;
    i_data <= 'b0;

	@(posedge i_rst_n);	//�ȴ���λ���
    
    @(posedge i_clk_p);
    i_en <= 'b1;
    i_data <= 'b0;
    
    @(posedge i_clk_p);
    
    repeat(255) begin
        i_data <= i_data +1;
        @(posedge i_clk_p);
    end


    i_en <= 'b1;
    i_data <= 'b0;
    
    #1000;
	$stop;
end


always @(posedge i_clk_p) begin
    if(o_vld) $display("%b",o_gray);
    else ;
end

endmodule






