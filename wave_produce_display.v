module wave_produce_display(
	input 			sys_clk,			//系统时钟信号50M；
	input 			rst,           //复位信号；
	input 			key1,          //波形选择按钮，用于改变输出波形的形状；
	
	input  [7:0]	ad_data,			//输入的AD数据；
	
	output [7:0]   da_data,       //输出给DA模块的波形数据；
	output 			da_clk,			//DA驱动时钟信号；
	
	output 			ad_clk,			//AD驱动时钟信号；
	
	output         tmds_clk_p,    // TMDS 时钟通道
   output         tmds_clk_n,
   output [2:0]   tmds_data_p,   // TMDS 数据通道
   output [2:0]   tmds_data_n

);

	reg    [9:0]	rom_addr = 0;
	reg	 [1:0]	wave_flag = 0; //波形标志，用于记录不同形状波形的序号；
	reg    [10:0]  sample_cnt = 0;
	reg    [9:0]   rdaddress = 0;
	reg    [2:0]   state;
	reg    [31:0]  wait_cnt;
	wire 	 [7:0]	rom_data;		//从ROM中读取的数据；
	wire   [7:0]   ram_out;
	wire				ad_buf_wren;
	
	wire 				pixel_clk;		//像素时钟；
   wire 				pixel_clk_5x;	//5倍像素时钟；
	wire 				clk_locked;
	wire  			clk_test;
	
	wire   [11:0]  pixel_xpos_w;	//像素点横坐标；
	wire   [11:0]  pixel_ypos_w;	//像素点纵坐标；
	wire   [23:0]  pixel_data_w;	//像素点数据；
	
	wire           video_hs;		//行同步信号；
	wire           video_vs;		//场同步信号；
	wire           video_de;		//数据使能；
	wire   [23:0]  video_rgb;		//RGB888颜色数据；
	
localparam       S_IDLE    = 0;
localparam       S_SAMPLE  = 1;
localparam       S_WAIT    = 2;

always @(posedge key1 or negedge rst)  //key1每按下一次，则切换到下一个波形；
	begin
	if(!rst)
		wave_flag<=0;
	else if(wave_flag<2) begin
			wave_flag<=(wave_flag+1'b1);
			end
		else begin
			wave_flag<=0;
			end
	end

//根据不同的wave_flag确定不同的ROM地址区间，从而输出不同波形；
always @(posedge sys_clk or negedge rst)
	begin
		if(!rst) begin
			rom_addr<=0;
			end
		else if(wave_flag == 0)begin
			if(rom_addr >= 10'h000 && rom_addr < 10'h0FE)
				rom_addr<=rom_addr+1;
			else begin
				rom_addr<=10'h000;
				end
			end
		else if(wave_flag == 1)begin
			if(rom_addr >= 10'h100 && rom_addr < 10'h1FE)
				rom_addr<=rom_addr+1;
			else begin
				rom_addr<=10'h100;
				end
			end
		else if(wave_flag == 2)begin
			if(rom_addr >= 10'h200 && rom_addr < 10'h2FE)
				rom_addr<=rom_addr+1;
			else begin
				rom_addr<=10'h200;
				end
			end
		else begin
			rom_addr<=rom_addr+1;
			end
	end	
	
always@(posedge ad_clk or negedge rst)
begin
	if(!rst)
	begin
		state <= S_IDLE;
		wait_cnt <= 32'd0;
		sample_cnt <= 11'd0;
	end
	else
		case(state)
			S_IDLE:
			begin
				state <= S_SAMPLE;
			end
			S_SAMPLE:
			begin
					if(sample_cnt == 11'd1023)
					begin
						sample_cnt <= 11'd0;
						state <= S_WAIT;
					end
					else
					begin
						sample_cnt <= sample_cnt + 11'd1;
					end
			end		
			S_WAIT:
			begin
//`ifdef  TRIGGER				
//				if(adc_data_valid == 1'b1 && adc_data_d1 < 8'd127 && adc_data_d0 >= 8'd127)
//					state <= S_SAMPLE;
//`else
				if(wait_cnt == 32'd6_000_000)
				begin
					state <= S_SAMPLE;
					wait_cnt <= 32'd0;
				end
				else
				begin
					wait_cnt <= wait_cnt + 32'd1;
				end
//`endif					
			end	
			default:
				state <= S_IDLE;
		endcase
end

pll_clk my_pll_clk(					//例化PLL模块，产生75MHz及375MHz的时钟；
	.areset		(~rst),
	.inclk0		(sys_clk),
	
	.c0			(pixel_clk),
	.c1			(pixel_clk_5x),
	.c2			(clk_test),		//1M
	.locked		(clk_locked)
);
	
rom_8bit my_rom(						//例化ROM；
	.address		(rom_addr),
	.clock   	(sys_clk),
	
	.q				(rom_data)
);

da_drive my_da_drive(				//例化DA驱动模块；
	.clk			(sys_clk),
	.rom_data	(rom_data),
	
	.da_data		(da_data),
	.da_clk		(da_clk)
);


ad_drive my_ad_drive(				//例化AD驱动模块；
	.clk			(sys_clk),
	.ad_data		(ad_data),
	
	.ad_clk		(ad_clk)
);

video_driver my_video_driver(		//例化视频显示驱动模块；
	.pixel_clk  (pixel_clk),
   .sys_rst_n  (rst),

   .video_hs   (video_hs),
   .video_vs   (video_vs),
   .video_de   (video_de),
   .video_rgb  (video_rgb),

   .pixel_xpos (pixel_xpos_w),
   .pixel_ypos (pixel_ypos_w),
   .pixel_data (pixel_data_w)
);

always@(posedge pixel_clk)
begin
	if(pixel_ypos_w >= 12'd200 && pixel_ypos_w <= 12'd510 && pixel_xpos_w >= 12'd9 && pixel_xpos_w  <= 12'd1911)
		rdaddress <= rdaddress + 10'd1;
	else
		rdaddress <= 10'd0;
end

assign ad_buf_wren = (state == S_SAMPLE) ? 1'b1 : 1'b0;

ram1024_8 my_ram(
	.data			(ad_data),
	.wraddress	(sample_cnt),
	.wren			(ad_buf_wren),
	.wrclock		(ad_clk),
	
	.rdclock		(pixel_clk),
	.rdaddress	(rdaddress),
	
	.q				(ram_out)
);
//rom_8bit my_rom_test(						//例化ROM；
//	.address		(rdaddress),
//	.clock   	(pixel_clk),
//	
//	.q				(ram_out)
//);


video_display  my_video_display(	//例化视频显示模块；
    .pixel_clk      (pixel_clk),
    .sys_rst_n      (rst),
	 .datain			  (ram_out),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );

dvi_transmitter_top my_rgb2dvi(	//例化HDMI驱动模块;
    .pclk           (pixel_clk),
    .pclk_x5        (pixel_clk_5x),
    .reset_n        (rst & clk_locked),
                
    .video_din      (video_rgb),
    .video_hsync    (video_hs), 
    .video_vsync    (video_vs),
    .video_de       (video_de),
                
    .tmds_clk_p     (tmds_clk_p),
    .tmds_clk_n     (tmds_clk_n),
    .tmds_data_p    (tmds_data_p),
    .tmds_data_n    (tmds_data_n)
    );

endmodule
