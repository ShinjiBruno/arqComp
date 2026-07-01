-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_rom is
    port (
        address    : in  unsigned(6 downto 0);
        instr_out  : out unsigned(31 downto 0)
    );
end entity eq12_rom;

architecture a_eq12_rom of eq12_rom is
    type mem is array (0 to 127) of unsigned(31 downto 0);

    --opcodes
    constant OP_NOP  : unsigned(5 downto 0) := "000000";
    constant OP_MOV  : unsigned(5 downto 0) := "000001";
    constant OP_JMP  : unsigned(5 downto 0) := "000110";
    constant OP_ADDI : unsigned(5 downto 0) := "000010";
    constant OP_ADD  : unsigned(5 downto 0) := "000011";
    constant OP_SUB  : unsigned(5 downto 0) := "000100";
    constant OP_DIV  : unsigned(5 downto 0) := "000101";
    constant OP_BEQ  : unsigned(5 downto 0) := "000111";
    constant OP_BLT  : unsigned(5 downto 0) := "001000";

    constant ZERO19 : unsigned(18 downto 0) := (others => '0');

    constant rom_content : mem := (
        --Multiplicacao por somas (R2 = R4 * R5, com R4=5)
        -- R1 <- 1 (ADDI R1, R1, 1)
        0 => "000010" & "001" & "001" & "0000000000000" & "0000001",
         --R4 <- 5  (ADDI R4, R4, 5) 
        1  => "000010" & "100" & "100" & "0000000000000" & "0000101",
        -- R5 <- 7 (ADDI R5, R5, 7)  
        2  => "000010" & "101" & "101" & "0000000000000" & "0000111",
        -- R2 <- 0  (MOV R2, R0) 
        3  => "000001" & "010" & "000" & "0000000000000" & "0000000",
        -- R2 <- R2 + R5 (ADD R2, R2, R5)
        4  => "000011" & "010" & "010" & "101" & "0000000000" & "0000000",
        -- R4 <- R4 - 1    (SUB R4, R1)
        5  => "000100" & "100" & "100" & "001" & "0000000000" & "0000000",
        -- BEQ R4, R0, fim  (fim=8=0001000)
        6  => "000111" & "100" & "000" & "0000000000000" & "0001000",
        -- JMP loop   (loop=3=0000011)  
        7  => "000110" & "000" & "000" & "0000000000000" & "0000100",
        -- JMP 7  (loop infinito)
        8  => "000110" & "000" & "000" & "0000000000000" & "0001000",

        others => (others => '0')
    );

begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;
