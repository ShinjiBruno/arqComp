library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_Reg_ULA_Top_tb is
end entity Eq12_Reg_ULA_Top_tb;

architecture a_Reg_ULA_Top_tb of Eq12_Reg_ULA_Top_tb is
    constant T_CLK : time := 10 ns;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal we : std_logic := '0';

    signal a3  : std_logic_vector(2 downto 0) := (others => '0');
    signal a1  : std_logic_vector(2 downto 0) := (others => '0');
    signal a2  : std_logic_vector(2 downto 0) := (others => '0');
    signal op: unsigned(1 downto 0) := (others => '0');
    signal ulaSrc: std_logic := '0';
    signal sign_imm: unsigned(19 downto 0) := (others => '0');

    signal out_ULA : unsigned(19 downto 0);
    signal zero:     std_logic;
    signal lt:       std_logic;


    constant RA1_ORIG : natural := 246980;
    constant RA2_ORIG : natural := 244900 ;

begin
    reg_ula_top: entity work.Eq12_Reg_ULA_Top(a_Reg_ULA_Top) port map(
        clk => clk,
        rst => rst,
        we => we,
        a1 => a1,
        a2 => a2,
        a3 => a3,
        op => op,
        ulaSrc => ulaSrc,
        sign_imm => sign_imm,
        out_ula => out_ula,
        zero => zero,
        lt => lt
    );
    clk <= not clk after T_CLK / 2;


    sim: process
        begin
        rst <= '1';
        we <= '0';
        a1 <= "000";
        a2 <= "000";
        ulaSrc <= '0';
        wait for T_CLK;

        rst <= '0';
        we <= '1';
        wait for T_CLK;

        --constante+registrador $zero
        a1 <= "000"; 
        a3 <= "110"; -- gravar o resultado da ula em R6
        ulaSrc <= '1'; -- instrucao tipo I
        sign_imm <= to_unsigned(RA1_ORIG, 20);
        op <= "00"; -- operacao soma
        wait until rising_edge(clk);

        sign_imm <= to_unsigned(RA2_ORIG, 20);
        a3 <= "111"; -- resultado da ula em R7
        wait until rising_edge(clk);

        a3 <= "110"; -- R6 = R6/R7
        a1 <= "110";
        a2 <= "111";
        ulaSrc <= '0';
        op <= "10"; --operacao divisao
        we <='0';
        wait until rising_edge(clk);

        a1 <= "110";
        a2 <= "000";
        wait until rising_edge(clk);

        wait;
        end process;

end architecture a_Reg_ULA_Top_tb;