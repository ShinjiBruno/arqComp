library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
    port (
        clk: in std_logic;
        endereco: in unsigned(6 downto 0);
        dado: out unsigned(31 downto 0);
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(31 downto 0);
    constant conteudo_rom : mem := (
        0  => x"00000000"
        others => (others => '0')
    );
    dado <= conteudo_rom(to_integer(endereco));
end architecture;