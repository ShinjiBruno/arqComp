-- Autoria: Frederico Albert Vicente

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rom is
end entity;

architecture sim of tb_rom is

    component rom is
        port (
            clk: in std_logic;
            endereco: in unsigned(6 downto 0);
            dado: out unsigned(11 downto 0)
        );
    end component;

    signal clk_tb      : std_logic := '0';
    signal endereco_tb : unsigned(6 downto 0) := (others => '0');
    signal dado_tb     : unsigned(11 downto 0);

    constant tempo_espera : time := 10 ns;

begin
    UUT: rom port map(
        clk      => clk_tb,
        endereco => endereco_tb,
        dado     => dado_tb
    );

    p_clock: process
    begin
        clk_tb <= '0';
        wait for tempo_espera / 2;
        clk_tb <= '1';
        wait for tempo_espera / 2;
    end process;

    p_estimulos: process
    begin
        wait for tempo_espera;

        -- Endere�o 0 (retorna x"00000000")
        endereco_tb <= to_unsigned(0, 7);
        wait for tempo_espera; 

        -- Endere�o 1 (retorna '0')
        endereco_tb <= to_unsigned(1, 7);
        wait for tempo_espera;

        -- Endere�o 10 (retorna '0')
        endereco_tb <= to_unsigned(10, 7);
        wait for tempo_espera;
        
        -- Endere�o 127 (limite, retorna '0')
        endereco_tb <= to_unsigned(127, 7);
        wait for tempo_espera;

        wait;
    end process;

end architecture;