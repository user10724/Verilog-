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
module testbench_top();
reg a= 0;
reg b =0;
reg clk =0;

initial begin
    #100;
    a=1;

end


initial begin
    #50;
    b=1;
    #100;
    $stop;
end



always    #10 clk = ~ clk;

initial begin
    #10;
    $display("%0tps",$time);
    #5.481;
    $display("%0tps",$time);
    #10.58289;
    $display("%0fns",$realtime);
    $display("%0tps",$time);
    #10;
    $display("%0tps",$time);

end

endmodule






