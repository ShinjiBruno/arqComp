library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_eq12_maq_estados_tb is 
end entity;

architecture sim of tb_eq12_maq_estados_tb is

    component eq12_maq_estados is 
        port(
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            o_estado : out std_logic
        );
    end component;

    signal clk_tb      : std_logic := '0';
    signal rst_tb      : std_logic := '0';
    signal wr_en_tb    : std_logic := '0';
    signal o_estado_tb : std_logic;

    constant clk_period : time := 10 ns;

begin
    UUT: eq12_maq_estados port map(
        clk      => clk_tb,
        rst      => rst_tb,
        wr_en    => wr_en_tb,
        o_estado => o_estado_tb
    );

    p_clock: process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Processo de estímulos para testar o Flip-Flop T e o Reset
    p_estimulos: process
    begin
        -- teste reset
        rst_tb <= '1';
        wr_en_tb <= '0';
        wait for clk_period * 2;

        -- teste funcionamento normal
        rst_tb <= '0';
        wr_en_tb <= '1';
        wait for clk_period * 4; 

        -- teste write enable
        wr_en_tb <= '0';
        wait for clk_period * 2;

        -- teste reset aleatorio
        wr_en_tb <= '1';
        wait for clk_period * 1.5; -- Deixa rodar um pouco
        rst_tb <= '1';             -- Força o reset abruptamente
        wait for clk_period * 2;

        wait;
    end process;

end architecture;
