library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_ROM_PC_UC_tb is
end entity Eq12_ROM_PC_UC_tb;

architecture tb of Eq12_ROM_PC_UC_tb is
    constant T_CLK : time := 10 ns;

	signal clk    : std_logic := '0';
	signal rst    : std_logic := '1';
	signal wr_en  : std_logic := '0';

	signal instr_out   : unsigned(31 downto 0);
	signal address_out : unsigned(6 downto 0);
	signal jump_en_sig : std_logic;
	signal pc_we_sig   : std_logic;
begin

	rom_pc_uc: entity work.eq12_rom_pc_uc(a_eq12_rom_pc_uc) port map(
		clk => clk,
		rst => rst,
		instr_out => instr_out,
		address_out => address_out,
		jump_en => jump_en_sig,
		pc_we => pc_we_sig
	);

	clk_gen: process
	begin
		for i in 0 to 99 loop
			clk <= '0';
			wait for T_CLK/2;
			clk <= '1';
			wait for T_CLK/2;
		end loop;
		wait; 
	end process clk_gen;

	stim: process
	begin
		rst <= '1';
		wait for 10 ns;

		rst <= '0';

		wait for 2000 ns;

		wait;
	end process stim;

end architecture tb;
