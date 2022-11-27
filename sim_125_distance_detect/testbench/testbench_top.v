
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

//wire o_clk_en;
wire o_trig;

reg i_echo;

wire [13:0] o_s_mm;
//wire [15:0] o_t_us;
////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	


vlg_design U_VLG_DESIGN_0(
    .i_clk_p                        ( i_clk_p                       ),
    .i_clk_n                        ( i_clk_n                       ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_echo                         ( i_echo                        ),
    .o_trig                         ( o_trig                        ),
    .o_s_mm                         ( o_s_mm                        )
);

	

/*
vlg_en #(
    .P_CLK_PERIOD                   ( `CLK_PERIORD                          ))
U_VLG_EN_0(
    .i_clk                          ( i_clk_p                        ),
    .i_rst_n                        ( i_rst_n                       ),
    .o_clk_en                       ( o_clk_en                      )
);


vlg_trig U_VLG_TRIG_0(
    .i_clk                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_clk_en                       ( o_clk_en                      ),
    .o_trig                         ( o_trig                        )
);

vlg_echo U_VLG_ECHO_0(
    .i_clk                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_clk_en                       ( o_clk_en                      ),
    .i_echo                         ( i_echo                        ),
    .o_t_us                         ( o_t_us                        )
);

*/

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
    
    i_echo = 0;
	@(posedge i_rst_n);	//�ȴ���λ���
    
    @(posedge i_clk_p);

    
    
    

    #200_000_000;
	
	
	$stop;
end

integer tricnt = 0;
integer dly_time;

always @(posedge o_trig) begin
    tricnt = tricnt+1;
    #5_000;
    i_echo = 1;
    dly_time = 11+{$random}%26011; //11<t <26011
    $display("Test %0d:\n distance of testbench = %0d mm", tricnt,function_t2s(dly_time));
    #(dly_time*1000);
    i_echo = 0;
end

//s =0.173t
 function real function_t2s;
     input real t;
     begin
         function_t2s = 0.173*t;
     end
 endfunction


initial begin
    $monitor("o_s_mm = %0d mm",o_s_mm);
end

endmodule






