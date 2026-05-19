library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_pc_top is
    port(
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        jump_en: in std_logic;
        address_jump: in unsigned(6 downto 0);

        address: out unsigned(6 downto 0)
    );
end entity eq12_pc_top;

architecture a_eq12_pc_top of eq12_pc_top is
    signal s_address_plus1 : unsigned(6 downto 0);
    signal s_address_in : unsigned(6 downto 0);
begin

        pc: entity work.eq12_pc(a_eq12_pc) port map(
            clk => clk, 
            rst => rst, 
            wr_en => wr_en, 
            address_in => s_address_in, 
            address_out => address
        );

        pc_plus1: entity work.eq12_pc_plus1(a_eq12_pc_plus1) port map(
            address_in => address,
            address_out => s_address_plus1
        );

        s_address_in <= address_jump when jump_en = '1' else s_address_plus1;

end architecture a_eq12_pc_top;