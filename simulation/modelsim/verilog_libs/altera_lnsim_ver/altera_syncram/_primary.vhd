library verilog;
use verilog.vl_types.all;
entity altera_syncram is
    generic(
        width_a         : integer := 1;
        widthad_a       : integer := 1;
        widthad2_a      : integer := 1;
        numwords_a      : integer := 0;
        outdata_reg_a   : string  := "UNREGISTERED";
        address_aclr_a  : string  := "NONE";
        outdata_aclr_a  : string  := "NONE";
        width_byteena_a : integer := 1;
        width_b         : integer := 1;
        widthad_b       : integer := 1;
        widthad2_b      : integer := 1;
        numwords_b      : integer := 0;
        rdcontrol_reg_b : string  := "CLOCK1";
        address_reg_b   : string  := "CLOCK1";
        outdata_reg_b   : string  := "UNREGISTERED";
        outdata_aclr_b  : string  := "NONE";
        indata_reg_b    : string  := "CLOCK1";
        byteena_reg_b   : string  := "CLOCK1";
        address_aclr_b  : string  := "NONE";
        width_byteena_b : integer := 1;
        clock_enable_input_a: string  := "NORMAL";
        clock_enable_output_a: string  := "NORMAL";
        clock_enable_input_b: string  := "NORMAL";
        clock_enable_output_b: string  := "NORMAL";
        clock_enable_core_a: string  := "USE_INPUT_CLKEN";
        clock_enable_core_b: string  := "USE_INPUT_CLKEN";
        read_during_write_mode_port_a: string  := "NEW_DATA_NO_NBE_READ";
        read_during_write_mode_port_b: string  := "NEW_DATA_NO_NBE_READ";
        read_during_write_mode_mixed_ports: string  := "DONT_CARE";
        enable_ecc      : string  := "FALSE";
        width_eccstatus : integer := 2;
        ecc_pipeline_stage_enabled: string  := "FALSE";
        outdata_sclr_a  : string  := "NONE";
        outdata_sclr_b  : string  := "NONE";
        enable_ecc_encoder_bypass: string  := "FALSE";
        enable_coherent_read: string  := "FALSE";
        enable_force_to_zero: string  := "FALSE";
        width_eccencparity: integer := 8;
        operation_mode  : string  := "BIDIR_DUAL_PORT";
        byte_size       : integer := 0;
        ram_block_type  : string  := "AUTO";
        init_file       : string  := "UNUSED";
        init_file_layout: string  := "UNUSED";
        maximum_depth   : integer := 0;
        intended_device_family: string  := "Arria 10";
        lpm_hint        : string  := "UNUSED";
        lpm_type        : string  := "altsyncram";
        implement_in_les: string  := "OFF";
        power_up_uninitialized: string  := "FALSE";
        sim_show_memory_data_in_port_b_layout: string  := "OFF";
        is_lutram       : vl_notype;
        is_bidir_and_wrcontrol_addb_clk0: vl_notype;
        is_bidir_and_wrcontrol_addb_clk1: vl_notype;
        dual_port_addreg_b_clk0: vl_notype;
        dual_port_addreg_b_clk1: vl_notype;
        i_byte_size_tmp : vl_notype;
        i_lutram_read   : vl_notype;
        enable_mem_data_b_reading: vl_notype;
        wrcontrol_wraddress_reg_b: vl_notype;
        is_write_on_positive_edge: integer := 1;
        lutram_single_port_fast_read: vl_notype;
        lutram_dual_port_fast_read: vl_notype;
        block_ram_output_unreg: vl_notype;
        s3_address_aclr_b: vl_notype;
        is_rom          : vl_notype;
        i_address_aclr_family_b: vl_notype
    );
    port(
        wren_a          : in     vl_logic;
        wren_b          : in     vl_logic;
        rden_a          : in     vl_logic;
        rden_b          : in     vl_logic;
        data_a          : in     vl_logic_vector;
        data_b          : in     vl_logic_vector;
        address_a       : in     vl_logic_vector;
        address_b       : in     vl_logic_vector;
        clock0          : in     vl_logic;
        clock1          : in     vl_logic;
        clocken0        : in     vl_logic;
        clocken1        : in     vl_logic;
        clocken2        : in     vl_logic;
        clocken3        : in     vl_logic;
        aclr0           : in     vl_logic;
        aclr1           : in     vl_logic;
        byteena_a       : in     vl_logic_vector;
        byteena_b       : in     vl_logic_vector;
        addressstall_a  : in     vl_logic;
        addressstall_b  : in     vl_logic;
        q_a             : out    vl_logic_vector;
        q_b             : out    vl_logic_vector;
        eccstatus       : out    vl_logic_vector;
        address2_a      : in     vl_logic_vector;
        address2_b      : in     vl_logic_vector;
        eccencparity    : in     vl_logic_vector;
        eccencbypass    : in     vl_logic;
        sclr            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width_a : constant is 1;
    attribute mti_svvh_generic_type of widthad_a : constant is 1;
    attribute mti_svvh_generic_type of widthad2_a : constant is 1;
    attribute mti_svvh_generic_type of numwords_a : constant is 1;
    attribute mti_svvh_generic_type of outdata_reg_a : constant is 1;
    attribute mti_svvh_generic_type of address_aclr_a : constant is 1;
    attribute mti_svvh_generic_type of outdata_aclr_a : constant is 1;
    attribute mti_svvh_generic_type of width_byteena_a : constant is 1;
    attribute mti_svvh_generic_type of width_b : constant is 1;
    attribute mti_svvh_generic_type of widthad_b : constant is 1;
    attribute mti_svvh_generic_type of widthad2_b : constant is 1;
    attribute mti_svvh_generic_type of numwords_b : constant is 1;
    attribute mti_svvh_generic_type of rdcontrol_reg_b : constant is 1;
    attribute mti_svvh_generic_type of address_reg_b : constant is 1;
    attribute mti_svvh_generic_type of outdata_reg_b : constant is 1;
    attribute mti_svvh_generic_type of outdata_aclr_b : constant is 1;
    attribute mti_svvh_generic_type of indata_reg_b : constant is 1;
    attribute mti_svvh_generic_type of byteena_reg_b : constant is 1;
    attribute mti_svvh_generic_type of address_aclr_b : constant is 1;
    attribute mti_svvh_generic_type of width_byteena_b : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_input_a : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_output_a : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_input_b : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_output_b : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_core_a : constant is 1;
    attribute mti_svvh_generic_type of clock_enable_core_b : constant is 1;
    attribute mti_svvh_generic_type of read_during_write_mode_port_a : constant is 1;
    attribute mti_svvh_generic_type of read_during_write_mode_port_b : constant is 1;
    attribute mti_svvh_generic_type of read_during_write_mode_mixed_ports : constant is 1;
    attribute mti_svvh_generic_type of enable_ecc : constant is 1;
    attribute mti_svvh_generic_type of width_eccstatus : constant is 1;
    attribute mti_svvh_generic_type of ecc_pipeline_stage_enabled : constant is 1;
    attribute mti_svvh_generic_type of outdata_sclr_a : constant is 1;
    attribute mti_svvh_generic_type of outdata_sclr_b : constant is 1;
    attribute mti_svvh_generic_type of enable_ecc_encoder_bypass : constant is 1;
    attribute mti_svvh_generic_type of enable_coherent_read : constant is 1;
    attribute mti_svvh_generic_type of enable_force_to_zero : constant is 1;
    attribute mti_svvh_generic_type of width_eccencparity : constant is 1;
    attribute mti_svvh_generic_type of operation_mode : constant is 1;
    attribute mti_svvh_generic_type of byte_size : constant is 1;
    attribute mti_svvh_generic_type of ram_block_type : constant is 1;
    attribute mti_svvh_generic_type of init_file : constant is 1;
    attribute mti_svvh_generic_type of init_file_layout : constant is 1;
    attribute mti_svvh_generic_type of maximum_depth : constant is 1;
    attribute mti_svvh_generic_type of intended_device_family : constant is 1;
    attribute mti_svvh_generic_type of lpm_hint : constant is 1;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
    attribute mti_svvh_generic_type of implement_in_les : constant is 1;
    attribute mti_svvh_generic_type of power_up_uninitialized : constant is 1;
    attribute mti_svvh_generic_type of sim_show_memory_data_in_port_b_layout : constant is 1;
    attribute mti_svvh_generic_type of is_lutram : constant is 3;
    attribute mti_svvh_generic_type of is_bidir_and_wrcontrol_addb_clk0 : constant is 3;
    attribute mti_svvh_generic_type of is_bidir_and_wrcontrol_addb_clk1 : constant is 3;
    attribute mti_svvh_generic_type of dual_port_addreg_b_clk0 : constant is 3;
    attribute mti_svvh_generic_type of dual_port_addreg_b_clk1 : constant is 3;
    attribute mti_svvh_generic_type of i_byte_size_tmp : constant is 3;
    attribute mti_svvh_generic_type of i_lutram_read : constant is 3;
    attribute mti_svvh_generic_type of enable_mem_data_b_reading : constant is 3;
    attribute mti_svvh_generic_type of wrcontrol_wraddress_reg_b : constant is 3;
    attribute mti_svvh_generic_type of is_write_on_positive_edge : constant is 1;
    attribute mti_svvh_generic_type of lutram_single_port_fast_read : constant is 3;
    attribute mti_svvh_generic_type of lutram_dual_port_fast_read : constant is 3;
    attribute mti_svvh_generic_type of block_ram_output_unreg : constant is 3;
    attribute mti_svvh_generic_type of s3_address_aclr_b : constant is 3;
    attribute mti_svvh_generic_type of is_rom : constant is 3;
    attribute mti_svvh_generic_type of i_address_aclr_family_b : constant is 3;
end altera_syncram;
