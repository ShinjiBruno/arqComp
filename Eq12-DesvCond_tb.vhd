-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_DesvCond_tb is
end entity Eq12_DesvCond_tb;

architecture tb of Eq12_DesvCond_tb is
    constant T_CLK : time := 1 ns;

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';
begin

    uut: entity work.eq12_proc_top(a_eq12_proc_top)
        port map (
            clk => clk,
            rst => rst
        );

    -- clock generator
    clk_gen: process
    begin
        for i in 0 to 150000 loop
            clk <= '0'; wait for T_CLK/2;
            clk <= '1'; wait for T_CLK/2;
        end loop;
        wait;
    end process;

    -- estimulos
    stim: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        wait for 6 us;
        wait;
    end process stim;

end architecture tb;
