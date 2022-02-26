module da_drive(
	input 	[7:0] rom_data,
	input				clk,			//系统时钟信号，50M；
	
	output	[7:0] da_data,		//输出的DA数据；
	output			da_clk		//DA驱动时钟信号；
);

//DA芯片在da_clk上升沿（clk下降沿）时刻锁存数据，clk上升沿时刻会更新ROM中读取的数据；
assign da_clk = ~clk;			

assign da_data = rom_data;

endmodule
