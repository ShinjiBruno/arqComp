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

        -- R2 <- 2   (ADDI reg2=010, imm=2)
        0 => "000010" & "010" & "010" & "0000000000000" & "0000010",
        -- R4 <- 4   (ADDI reg2=100(4), imm=4)
        1  => "000010" & "100" & "100" & "0000000000000" & "0000100",
        -- R5 <- 6   (ADDI reg2=101, imm=6)
        2  => "000010" & "101" & "101" & "0000000000000" & "0000110",
        -- R6 <- R4 + R5  (ADD reg1=100, reg2=110)
        3  => "000011" & "110" & "100" & "101" & "0000000000" & "0000000",
        -- R6 <- R6 - R2 (SUB reg1=010, reg2=110)
        4  => "000100" & "110" & "110" & "010" & "0000000000" & "0000000",
        -- JMP 16   
        5  => "000110" & "000" & "000" & "0000000000000" & "0010000",
        -- NOP
        6  => "000000" & "000" & "000" & "0000000000000" & "0000000",
        7  => "000000" & "000" & "000" & "0000000000000" & "0000000",
        8  => "000000" & "000" & "000" & "0000000000000" & "0000000",
        9  => "000000" & "000" & "000" & "0000000000000" & "0000000",
        10 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        11 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        12 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        13 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        14 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        15 => "000000" & "000" & "000" & "0000000000000" & "0000000",
        --  R4 <- R6       (MOV reg1=110(R6), reg2=100(R4))
        16 => "000001" & "100" & "110" & "0000000000000" & "0000000",
        --   DIV=000101, reg1=011, reg2=111
        17 => "000101" & "011" & "011" & "111" & "0000000000" & "0000000",
        --   JMP=000110, addr=2=0000010
        18 => "000110" & "000" & "000" & "0000000000000" & "0000011",

        others => (others => '0')
    );

begin
    instr_out <= rom_content(to_integer(address));
end architecture a_eq12_rom;
