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
        -- addi $s6, $zero, 1
        0  => "000010" & "110" & "000" & "0000000000000" & "0000001",
        
        -- addi $s7, $zero, 2
        1  => "000010" & "111" & "000" & "0000000000000" & "0000010",
        
        -- addi $s1, $zero, 1
        2  => "000010" & "001" & "000" & "0000000000000" & "0000001",
        
        -- addi $s2, $zero, 1
        3  => "000010" & "010" & "000" & "0000000000000" & "0000001",
        
        -- addi $s1, $s1, 2
        4  => "000010" & "001" & "001" & "0000000000000" & "0000010",
        
        -- addi $s2, $s2, 1
        5  => "000010" & "010" & "010" & "0000000000000" & "0000001",
        
        -- beq $s2, $s1, contaPrimo
        6  => "000111" & "010" & "001" & "0000000000000" & "0001101",
        
        -- addi $s3, $s1, 0
        7  => "000010" & "011" & "001" & "0000000000000" & "0000000",
        
        -- blt $s3, $s2, fimSub
        8  => "001000" & "011" & "010" & "0000000000000" & "0001011",
        
        -- sub $s3, $s3, $s2
        9  => "000100" & "011" & "011" & "010" & "0000000000" & "0000000",
        
        -- j loopSub
        10 => "000110" & "000" & "000" & "0000000000000" & "0001000",
        
        -- beq $s3, 0, loop
        11 => "000111" & "011" & "000" & "0000000000000" & "0000011",
        
        -- j loopDiv
        12 => "000110" & "000" & "000" & "0000000000000" & "0000101",
        
        -- addi $s6, $s6, 1
        13 => "000010" & "110" & "110" & "0000000000000" & "0000001",
        
        -- addi $s7, $s1, 0
        14 => "000010" & "111" & "001" & "0000000000000" & "0000000",
        
        -- j loop
        15 => "000110" & "000" & "000" & "0000000000000" & "0000011",

        others => (others => '0')
    );

begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;
