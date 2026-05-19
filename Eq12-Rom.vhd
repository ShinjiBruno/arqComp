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
        1 => "000010" & "00000000000000000000000101", -- pula para endereco 5
        2 => x"00000000",
        3 => x"00000000", 
        4 => x"00000000", 
        5 => x"00000000",
        6 => x"00000000",
        7 => x"00000000",
        8 => x"00000000",
        9 => x"00000000",
        10 => "000010" & "00000000000000000000000000",  -- volta p endereco 0
        11 => x"00000000",
        others => (others => '0')
    );
begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;