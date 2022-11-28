
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

wire w_bps_en;
wire w_bps_done;
wire w_rx_en;
wire [7:0] w_rx_data;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������

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
    task_uart_tx(8'haa);
	
    #100_000;
    task_uart_tx(8'h55);
    #100_000;
    task_uart_tx(8'ha5);
    #100_000;
    task_uart_tx(8'h5a);
    #100_000;
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


always @(posedge i_clk_p)
    if(w_rx_en) $display("w_rx_data = %x",w_rx_data);
    else ;

endmodule






