-- Autoria: Bruno Shinji
-- LAB 7 - Testbench do processador com desvios condicionais (multiplicacao por somas)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_DesvCond_tb is
end entity Eq12_DesvCond_tb;

architecture tb of Eq12_DesvCond_tb is
    constant T_CLK : time := 10 ns;

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';

    signal state    : unsigned(1 downto 0);
    signal pc       : unsigned(6 downto 0);
    signal instr    : unsigned(31 downto 0);

    signal R0_o, R2_o, R4_o : unsigned(19 downto 0);

    signal ula_in_a, ula_in_b, ula_out : unsigned(19 downto 0);
    signal flag_z, flag_lt : std_logic;

    signal jump_en_o, pc_we, reg_wr : std_logic;
begin

    uut: entity work.eq12_proc_top(a_eq12_proc_top)
        generic map (program => 1) -- LAB 7
        port map (
            clk       => clk,
            rst       => rst,
            state     => state,
            pc        => pc,
            instr     => instr,
            R0_o      => R0_o,
            R1_o      => open,
            R2_o      => R2_o,
            R3_o      => open,
            R4_o      => R4_o,
            R5_o      => open,
            R6_o      => open,
            R7_o      => open,
            ula_in_a  => ula_in_a,
            ula_in_b  => ula_in_b,
            ula_out   => ula_out,
            flag_z    => flag_z,
            flag_lt   => flag_lt,
            jump_en_o => jump_en_o,
            pc_we_o   => pc_we,
            reg_wr_o  => reg_wr
        );

    clk_gen: process
    begin
        for i in 0 to 999 loop
            clk <= '0'; wait for T_CLK/2;
            clk <= '1'; wait for T_CLK/2;
        end loop;
        wait;
    end process;

    stim: process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 us;
        wait;
    end process stim;

end architecture tb;
