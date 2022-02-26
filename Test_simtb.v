`timescale 1 ps / 1 ps
module Test_simtb(
					 );
					 
reg clk;
reg reset;
reg key1;
wire [7:0]data_final;

wave_produce_display inst_wave_produce_display(
						.sys_clk        (clk    ),
						.rst      (reset        ),
						.key1       (key1       ),
						.da_data  (data_final    )
						);

initial begin
	clk=0;
	reset=0;
	key1=0;
	#100;
	reset=1;
	
end

always #10000 clk=~clk;   //50M;
always begin #5000000;
			#5000000;
			#5000000;
			#5000000;
			#5000000;
			#5000000;
			#5000000;
			#5000000
			key1=~key1;
			end

endmodule
