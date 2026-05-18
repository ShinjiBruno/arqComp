library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_eq12_un_controle is 
end entity;

architecture sim of tb_eq12_un_controle is

    component eq12_un_controle is 
        port(
            clk         : in std_logic;
            rst         : in std_logic;
            instruction : in unsigned(31 downto 0);
            jump_en     : out std_logic;
            pc_wr       : out std_logic
        );
    end component;

    -- Sinais internos
    signal clk_tb         : std_logic := '0';
    signal rst_tb         : std_logic := '0';
    signal instruction_tb : unsigned(31 downto 0) := (others => '0');
    signal jump_en_tb     : std_logic;
    signal pc_wr_tb       : std_logic;

    constant clk_period : time := 10 ns;

begin

    UUT: eq12_un_controle port map(
        clk         => clk_tb,
        rst         => rst_tb,
        instruction => instruction_tb,
        jump_en     => jump_en_tb,
        pc_wr       => pc_wr_tb
    );

    p_clock: process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Processo de estímulos 
    p_estimulos: process
    begin
        -- teste reset
        rst_tb <= '1';
        wait for clk_period * 2;
        rst_tb <= '0';

        -- teste x"00000000"
        instruction_tb <= x"00000000";
        wait for clk_period * 2; 

        -- teste jump
        instruction_tb <= x"C000000F";
        wait for clk_period * 2;

        -- Finaliza a simulação
        wait;
    end process;

end architecture;