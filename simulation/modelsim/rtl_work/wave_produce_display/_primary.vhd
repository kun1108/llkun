library verilog;
use verilog.vl_types.all;
entity wave_produce_display is
    port(
        sys_clk         : in     vl_logic;
        rst             : in     vl_logic;
        key1            : in     vl_logic;
        ad_data         : in     vl_logic_vector(7 downto 0);
        da_data         : out    vl_logic_vector(7 downto 0);
        da_clk          : out    vl_logic;
        ad_clk          : out    vl_logic
    );
end wave_produce_display;
