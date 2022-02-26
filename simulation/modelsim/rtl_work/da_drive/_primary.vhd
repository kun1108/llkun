library verilog;
use verilog.vl_types.all;
entity da_drive is
    port(
        rom_data        : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        da_data         : out    vl_logic_vector(7 downto 0);
        da_clk          : out    vl_logic
    );
end da_drive;
