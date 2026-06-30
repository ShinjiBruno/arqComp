-- Autoria: Bruno Shinji

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_un_controle is 
    port(
        clk: in std_logic;
        rst: in std_logic;
        instruction: in unsigned(31 downto 0);

        pcWrite: out std_logic;
        pc_wr: out std_logic;
        regWrite: out std_logic;
        beq: out std_logic;
        blt: out std_logic;
        ulaSrc: out std_logic;
        ulaOp: out unsigned(1 downto 0);
        isImm: out std_logic;
        isMov: out std_logic
    );
end entity eq12_un_controle;

architecture a_eq12_un_controle of eq12_un_controle is
    signal s_estado : unsigned(1 downto 0) := "00";
    signal s_wr_en_maqest : std_logic := '1';
    signal opcode : unsigned(5 downto 0);
    signal s_isImm: std_logic;
    signal s_isMov: std_logic;
    signal s_ula_op: unsigned(1 downto 0);
 begin

        maq_est: entity work.eq12_maq_estados(a_eq12_maq_estados) port map(
            clk => clk, 
            rst => rst, 
            wr_en => s_wr_en_maqest, 
            o_estado => s_estado
        );
        opcode <= instruction(31 downto 26);
        s_isImm <= '1' when opcode = "000110" OR opcode = "000111" OR opcode = "001000" OR opcode = "000010" else '0'; --sinal pra indicar se eh instr do tipo I
        s_isMov <= '1' when opcode = "000001" else '0';
        pcWrite <= '1' when opcode = "000110"  else '0'; --jump
        beq <= '1' when opcode = "000111" else '0'; --beq
        blt <= '1' when opcode = "001000"  else '0'; --blt 
        ulaSrc <= '1' when opcode = "000010" OR opcode = "000001" else '0'; --ula

        with opcode select
            s_ula_op <= "00" when "000011", --add (ADD)
                     "00" when "000010", --add (ADDI)
                      "01" when "000100", --sub
                      "10" when "000101", --div
                      "11" when others; 

        ulaOp <= s_ula_op when s_isMov = '0' else "00";
        regWrite <= '1' when s_estado = "10" else '0';
        pc_wr <= '1' when s_estado = "11" else '0'; 
        isMov <= s_isMov;
        isImm <= s_isImm;

end architecture a_eq12_un_controle;