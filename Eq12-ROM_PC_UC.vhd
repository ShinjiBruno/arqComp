-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_rom_pc_uc is
    port(
        clk: in std_logic;
        rst : in std_logic;
        lt: in std_logic;   
        zero: in std_logic; 
        address_jump: in unsigned(6 downto 0); 

        address_out: out unsigned(6 downto 0); --debug
        instr_out: out unsigned(31 downto 0);
        ulaOp: out unsigned(1 downto 0);
        ulaSrc: out std_logic;
        regWrite: out std_logic;
        loadCte: out std_logic;
        jumpInstr: out std_logic
    );
end entity eq12_rom_pc_uc;

architecture a_eq12_rom_pc_uc of eq12_rom_pc_uc is
    signal s_pc_wr: std_logic;
    signal s_pc_we: std_logic;
    signal s_jump_en: std_logic;
    signal s_address: unsigned(6 downto 0);
    signal s_instr: unsigned(31 downto 0);
    signal s_ulaOp: unsigned(1 downto 0);
    signal s_ulaSrc: std_logic;
    signal s_regWrite: std_logic;
    signal s_blt: std_logic;
    signal s_beq: std_logic;
    signal s_pcWrite: std_logic;
    signal s_loadCte:std_logic;
    signal s_jumpInstr: std_logic;
   
begin
    pc_top: entity work.eq12_pc_top(a_eq12_pc_top) port map(
        clk => clk,
        rst => rst,
        wr_en => s_pc_we,
        jump_en => s_jump_en,
        address_jump => address_jump,
        address => s_address
    );

    rom: entity work.eq12_rom(a_eq12_rom) port map(
        address => s_address,
        instr_out => s_instr
    );

    un_controle: entity work.eq12_un_controle(a_eq12_un_controle) port map(
        clk => clk,
        rst => rst,
        instruction => s_instr,

        pcWrite => s_pcWrite,
        pc_wr => s_pc_we,
        regWrite => s_regWrite,
        beq => s_beq,
        blt => s_blt,
        ulaSrc => s_ulaSrc,
        ulaOp => s_ulaOp,
        loadCte => s_loadCte,
        jumpInstr => s_jumpInstr
    );

    s_jump_en <= '1' when (zero = '1' and s_beq = '1') or (lt = '1' and s_blt = '1') or (s_pcWrite = '1') else '0';

    instr_out <= s_instr;
    address_out <= s_address;
    ulaOp <= s_ulaOp;
    ulaSrc <= s_ulaSrc;
    regWrite <= s_regWrite;
    loadCte <= s_loadCte;
    jumpInstr <= s_jumpInstr;


end architecture a_eq12_rom_pc_uc;
