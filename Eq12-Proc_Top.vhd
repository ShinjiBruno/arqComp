-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_proc_top is
    port(
        clk: in std_logic;
        rst: in std_logic
    );
end entity eq12_proc_top;

architecture a_eq12_proc_top of eq12_proc_top is
    signal s_lt: std_logic;
    signal s_zero: std_logic;
    signal s_regWrite: std_logic;
    signal s_ulaSrc: std_logic;
    signal s_ulaOp: unsigned(1 downto 0);
    signal s_address_jump: unsigned(6 downto 0);
    signal s_address: unsigned(6 downto 0);
    signal s_out_ULA: unsigned(19 downto 0);
    signal s_instr: unsigned(31 downto 0);

    signal s_a1: std_logic_vector(2 downto 0);
    signal s_a2: std_logic_vector(2 downto 0);
    signal s_a3: std_logic_vector(2 downto 0);
    signal s_sign_imm: unsigned(19 downto 0);

    signal s_loadCte: std_logic;  
    signal s_jumpInstr: std_logic;

begin
    rom_pc_uc: entity work.eq12_rom_pc_uc(a_eq12_rom_pc_uc) port map(
        clk => clk,
        rst => rst,
        lt => s_lt,
        zero => s_zero,
        address_jump => s_address_jump,

        address_out => s_address,
        instr_out => s_instr,
        ulaOp => s_ulaOp,
        ulaSrc => s_ulaSrc,
        regWrite => s_regWrite,
        loadCte => s_loadCte,
        jumpInstr => s_jumpInstr
    );

    reg_ula: entity work.Eq12_Reg_ULA_Top(a_Reg_ULA_Top) port map(
        clk => clk,
        rst => rst,
        we => s_regWrite,   
        a1 => s_a1,
        a2 => s_a2,
        a3 => s_a3,
        op => s_ulaOp,
        ulaSrc => s_ulaSrc,
        sign_imm => s_sign_imm,

        out_ULA => s_out_ULA,
        zero => s_zero,
        lt => s_lt
    );


    s_address_jump <= s_instr(6 downto 0);
    s_a1 <= std_logic_vector(s_instr(25 downto 23)) when s_jumpInstr='1' else std_logic_vector(s_instr(22 downto 20));
    s_a2 <= "000" when s_loadCte = '1' else std_logic_vector(s_instr(22 downto 20)) when s_jumpInstr = '1' else std_logic_vector(s_instr(19 downto 17));
    s_a3 <= std_logic_vector(s_instr(25 downto 23));
     
    s_sign_imm <=("000" & s_instr(16 downto 0)) when s_loadCte = '0' else s_instr(19 downto 0);


end architecture a_eq12_proc_top;
