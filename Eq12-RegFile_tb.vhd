library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_RegFile_tb is
end entity Eq12_RegFile_tb;

architecture tb of Eq12_RegFile_tb is
    constant T_CLK : time := 10 ns;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal we3 : std_logic := '0';

    signal wd3 : unsigned(19 downto 0) := (others => '0');
    signal a3  : std_logic_vector(2 downto 0) := (others => '0');
    signal a1  : std_logic_vector(2 downto 0) := (others => '0');
    signal a2  : std_logic_vector(2 downto 0) := (others => '0');

    signal rd1 : unsigned(19 downto 0);
    signal rd2 : unsigned(19 downto 0);

    constant RA1_ORIG : natural := 2469804;
    constant RA2_ORIG : natural := 2449005;
    constant RA3_ORIG : natural := 123456;

    constant RA1_20B : natural := RA1_ORIG mod (2 ** 20);
    constant RA2_20B : natural := RA2_ORIG mod (2 ** 20);
    constant RA3_20B : natural := RA3_ORIG mod (2 ** 20);
begin
    uut: entity work.Eq12_RegFile
        port map (
            clk => clk,
            rst => rst,
            we3 => we3,
            wd3 => wd3,
            a3  => a3,
            a1  => a1,
            a2  => a2,
            rd1 => rd1,
            rd2 => rd2
        );

    clk <= not clk after T_CLK / 2;

    stim_proc: process
    begin
        rst <= '1';
        we3 <= '0';
        a1 <= "000";
        a2 <= "000";
        wait for 2 * T_CLK;
        rst <= '0';
        wait for T_CLK;

        we3 <= '1';

        a3  <= "001";
        wd3 <= to_unsigned(RA1_20B, 20);
        wait until rising_edge(clk);

        a3  <= "010";
        wd3 <= to_unsigned(RA2_20B, 20);
        wait until rising_edge(clk);

        a3  <= "011";
        wd3 <= to_unsigned(RA3_20B, 20);
        wait until rising_edge(clk);

        we3 <= '0';
        wait for T_CLK;

        a1 <= "000";
        a2 <= "001";
        wait for T_CLK;

        a2 <= "010";
        wait for T_CLK;

        a2 <= "011";
        wait for T_CLK;

        a2 <= "000";
        a1 <= "001";
        wait for T_CLK;

        a1 <= "010";
        wait for T_CLK;

        a1 <= "011";
        wait for T_CLK;

        wait;
    end process;
end architecture tb;