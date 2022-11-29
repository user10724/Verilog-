
/////////////////////////////////////////////////////////////////////////////
//EDA����ƽ̨��Vivado 2021.2 + ModelSim SE-64 20.4 
//�����׼��ͺţ� kintex7 genesys2
//����: NJU zhoutao

//�������� ��ʱ�Ӹĳ�5.0ns ���治�� ��20ns ��ȷ�� ԭ��5.0��������

/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		5		//ʱ����������Ϊ5ns��200MHz��	
parameter UART_BPS_RATE = 115200;
parameter BPS_DLY_BIT =1_000_000_000/UART_BPS_RATE;

////////////////////////////////////////////////////////////
//�ӿ�����
	
reg i_clk_p;
reg i_clk_n;
reg i_rst_n;

reg i_uart_rx;

/*
wire w_bps_en;
wire w_bps_done;
wire w_rx_en;
wire [7:0] w_rx_data;

wire o_led_en;
wire [31:0] o_led_periord;
wire [31:0] o_led_high;
wire [15:0] o_led_num;
*/
wire o_pwm;
////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
/*
m_bps #(
    .UART_BPS_RATE                  ( UART_BPS_RATE                        ),
    .CLK_PERIORD                    ( `CLK_PERIORD                             ))
U_M_BPS_0(
    .i_clk                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_bps_en                       ( w_bps_en                      ),
    .o_bps_done                     ( w_bps_done                    )
);


m_s2p U_M_S2P_0(
    .i_clk                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_uart_rx                      ( i_uart_rx                     ),
    .i_bps_done                     ( w_bps_done                    ),
    .o_bps_en                       ( w_bps_en                      ),
    .o_rx_en                        ( w_rx_en                       ),
    .o_rx_data                      ( w_rx_data                     )
);


m_decoder U_M_DECODER_0(
    .i_clk                          ( i_clk_p                         ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_rx_en                        ( w_rx_en                       ),
    .i_rx_data                      ( w_rx_data                     ),
    .o_led_en                       ( o_led_en                      ),
    .o_led_periord                  ( o_led_periord                 ),
    .o_led_high                     ( o_led_high                    ),
    .o_led_num                      ( o_led_num                     )
);
*/

vlg_design U_VLG_DESIGN_0(
    .i_clk_p                        ( i_clk_p                       ),
    .i_clk_n                        ( i_clk_n                       ),
    .i_rst_n                        ( i_rst_n                       ),
    .i_uart_rx                      ( i_uart_rx                     ),
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
always #(`CLK_PERIORD/2.0) i_clk_p <= ~i_clk_p;	

always #(`CLK_PERIORD/2.0) i_clk_n <= ~i_clk_n;
////////////////////////////////////////////////////////////
//���Լ�������

initial begin

    i_uart_rx <= 'b1;

	@(posedge i_rst_n);	//�ȴ���λ���
    
    @(posedge i_clk_p);

    #100_000;
    task_cmd_tx(32'd1000,32'd100,16'd5);
	
    #1000_000;
    task_cmd_tx(32'd5000,32'd1000,16'd5);
    #1000_000;
	$stop;
end


///////////
//ģ��һ��UART���������
integer i;
        
task task_uart_tx;
    input [7:0] tx_db;
    begin
        i_uart_rx <= 'b0;
        #BPS_DLY_BIT;
        for(i=0;i<8;i=i+1)begin
            i_uart_rx <= tx_db[i];
            #BPS_DLY_BIT;
        end
        i_uart_rx <= 'b1;
        #BPS_DLY_BIT;
    end
endtask

///////
//ģ��һ��������UART����֡
task task_cmd_tx;
    input [31:0] tx_led_periord;
    input [31:0] tx_led_high;
    input [15:0] tx_led_num;
    begin
        task_uart_tx(8'haa);
        task_uart_tx(8'h55);
        task_uart_tx(8'ha5);
        task_uart_tx(8'h5a);

        
        task_uart_tx(tx_led_periord[31:24]);
        task_uart_tx(tx_led_periord[23:16]);
        task_uart_tx(tx_led_periord[15:8]);
        task_uart_tx(tx_led_periord[7:0]);

        task_uart_tx(tx_led_high[31:24]);
        task_uart_tx(tx_led_high[23:16]);
        task_uart_tx(tx_led_high[15:8]);
        task_uart_tx(tx_led_high[7:0]);


        task_uart_tx(tx_led_num[15:8]);
        task_uart_tx(tx_led_num[7:0]);
        
        task_uart_tx(8'hcc);
        task_uart_tx(8'h33);
        task_uart_tx(8'hc3);
        task_uart_tx(8'h3c);
    end
endtask



/*
always @(posedge i_clk_p)
    if(o_led_en) $display("o_led_periord = %x ,high = %x ,num = %x",
        o_led_periord,o_led_high,o_led_num);
    else ;
*/
endmodule






