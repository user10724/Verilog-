
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
reg i_en    ;
reg [31:0]    i_period;       //���ڣ� ��λ5ns
reg [31:0]    i_high;         //�ߵ�ƽʱ��    ��λ5ns
reg [15:0]    i_times;        //����
wire o_pwm;
////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	

vlg_design U_VLG_DESIGN_0(
    .i_clk_p                        ( i_clk_p                       ),
    .i_clk_n                        ( i_clk_n                       ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_en                           ( i_en                          ),
    .i_period                       ( i_period                      ),
    .i_high                         ( i_high                        ),
    .i_times                        ( i_times                       ),
    .o_pwm                          ( o_pwm                         )
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

    i_en        <=1'b0;
    i_period    <= 32'd0;       //���ڣ� ��λ5ns
    i_high      <= 32'd0;    //�ߵ�ƽʱ��    ��λ5ns
    i_times     <= 32'd0;   //����
	@(posedge i_rst_n);	//�ȴ���λ���
    #1000;
    @(posedge i_clk_p);
    
    task_pwm_setting(2500,250,3);

    #100_000;
    task_pwm_setting(1000,500,5);
   
    #10_000;
	
	$stop;
end

task task_pwm_setting;
    input[31:0] pwm_period;
    input[31:0] pwm_high;
    input[15:0] pwm_times;
    begin
        @(posedge i_clk_p);
        i_en <= 1'b1;

        i_period <= pwm_period;
        i_high  <= pwm_high;
        i_times <= pwm_times;

        #(pwm_period*pwm_times*`CLK_PERIORD);
        @(posedge i_clk_p);
        i_en    <= 1'b0;
    end
endtask


endmodule






