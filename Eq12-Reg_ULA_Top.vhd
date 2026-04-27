library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_Reg_ULA_Top is
    port (
        clk:    in std_logic;
        rst:    in std_logic;
        we:     in std_logic;
        a1:     in std_logic_vector(2 downto 0);  
        a2:     in std_logic_vector(2 downto 0);
        a3:     in std_logic_vector(2 downto 0);
        op:     in unsigned(1 downto 0); 
        ulaSrc: in std_logic;
        sign_imm: in unsigned(19 downto 0);
    
        out_ULA:out unsigned(19 downto 0);
        zero:   out std_logic;
        lt:     out std_logic
    );
end entity Eq12_Reg_ULA_Top;

architecture a_Reg_ULA_Top of Eq12_Reg_ULA_Top is 
    signal s_rd1: unsigned(19 downto 0) := (others => '0');
    signal s_rd2: unsigned(19 downto 0) := (others => '0');
    signal s_srcB: unsigned(19 downto 0) := (others => '0');

    signal s_out_ula: unsigned(19 downto 0);

begin
    RegFile: entity work.Eq12_RegFile(a_Eq12_RegFile) port map(
        clk => clk, 
        rst => rst,
        we3 => we, 
        a1 => a1, 
        a2=>a2, 
        a3=>a3, 
        wd3=>s_out_ula, --saida da ula em write data
        rd1=> s_rd1,
        rd2=>s_rd2
    );

    ULA: entity work.ula(rtl) port map(
        in_A=>s_rd1, 
        in_B=>s_srcB, 
        op=>op, 
        out_ULA=>s_out_ula, 
        zero=>zero, 
        lt=>lt
    );

    with ulaSrc select
        s_srcB <= s_rd2     when '0',
                  sign_imm  when others;

    out_ULA <= s_out_ula;


end architecture a_Reg_ULA_Top;