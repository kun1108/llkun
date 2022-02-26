library verilog;
use verilog.vl_types.all;
entity ad_drive is
    port(
        clk             : in     vl_logic;
        ad_data         : in     vl_logic_vector(7 downto 0);
        ad_clk          : out    vl_logic
    );
end ad_drive;
