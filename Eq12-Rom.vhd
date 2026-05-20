-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_rom is 
    port (
        address: in unsigned(6 downto 0);
        instr_out: out unsigned(11 downto 0)
    );
end entity eq12_rom;

architecture a_eq12_rom of eq12_rom is
    type mem is array (0 to 127) of unsigned(11 downto 0);
    constant rom_content : mem := (
        0 => x"000",
        1 => "000010" & "000101", -- pula para endereco 5
        2 => x"000",
        3 => x"000", 
        4 => x"000", 
        5 => x"000",
        6 => x"000",
        7 => x"000",
        8 => x"000",
        9 => x"000",
        10 => "000010" & "000000",  -- volta p endereco 0
        11 => x"000",
        others => (others => '0')
    );
begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;