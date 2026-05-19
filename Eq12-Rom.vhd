library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_rom is 
    port (
        address: in unsigned(6 downto 0);
        instr_out: out unsigned(31 downto 0)
    );
end entity eq12_rom;

architecture a_eq12_rom of eq12_rom is
    type mem is array (0 to 127) of unsigned(31 downto 0);
    constant rom_content : mem := (
        0 => x"00000000",
        1 => x"00000000",
        2 => "000010" & "00000000000000000000000100", -- pula para endereco 4
        3 => "000010" & "00000000000000000000000111", -- pula p endereco7
        4 => "000010" & "00000000000000000000000011", -- pula p endereco 3
        5 => x"00000000",
        6 => x"00000000",
        7 => x"00000000",
        8 => x"00000000",
        9 => x"00000000",
        10 => "000010" & "00000000000000000000000001",  -- volta p endereco 1
        11 => x"00000000",
        others => (others => '0')
    );
begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;