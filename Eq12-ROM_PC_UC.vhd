library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_rom_pc_uc is
    port(
        clk: in std_logic;
        rst : in std_logic;
        instr_out: out unsigned(31 downto 0);
        address_out: out unsigned(6 downto 0);
        jump_en: out std_logic;
        pc_we: out std_logic
    );
end entity eq12_rom_pc_uc;

architecture a_eq12_rom_pc_uc of eq12_rom_pc_uc is
    signal s_pc_wr: std_logic;
    signal s_pc_we: std_logic;
    signal s_jump_en: std_logic;
    signal s_address: unsigned(6 downto 0);
    signal s_instr: unsigned(31 downto 0);
    signal s_address_jump: unsigned(6 downto 0);

begin
    pc_top: entity work.eq12_pc_top(a_eq12_pc_top) port map(
        clk => clk,
        rst => rst,
        wr_en => s_pc_we,
        jump_en => s_jump_en,
        address_jump => s_address_jump,
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
        jump_en => s_jump_en,
        pc_wr => s_pc_we
    );

    s_address_jump <= s_instr(6 downto 0);

    instr_out <= s_instr;
    address_out <= s_address;
    jump_en <= s_jump_en;
    pc_we <= s_pc_we;

end architecture a_eq12_rom_pc_uc;