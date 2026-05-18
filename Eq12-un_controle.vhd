library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_un_controle is 
    port(
        clk: in std_logic;
        rst: in std_logic;

        instruction: in unsigned(31 downto 0);
        jump_en: out std_logic;
        pc_wr: out std_logic;
    );
end entity;

architecture a_eq12_un_controle of eq12_un_controle is
    signal s_estado : std_logic := '0';

 begin
        maq_est: entity work.eq12_maq_estados(a_eq12_maq_estados) port map(
            clk => clk, 
            rst => rst, 
            wr_en => s_wr_en_maqest, 
            o_estado => s_estado
        );

        jump_en <= '1' when s_estado = '0' else '0'; -- ler qnd fetch
        pc_wr <= '1' when s_estado = '1' else '0';



end architecture;