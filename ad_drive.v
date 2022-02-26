module ad_drive(
	input 		clk,
	input [7:0] ad_data,
	
	output reg	ad_clk		//AD驱动时钟信号；
	
);


//由于所用AD芯片最大时钟频率为32Mhz，因此需对50M时钟进行二分频；
always @(posedge clk)begin
	ad_clk <= ~ad_clk;
end

endmodule
