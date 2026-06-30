-- Autoria: Bruno Shinji
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port (
		in_A    : in  unsigned(19 downto 0);
		in_B    : in  unsigned(19 downto 0);
		op      : in  unsigned(1 downto 0);
		out_ULA : out unsigned(19 downto 0);
		zero    : out std_logic;
		lt      : out std_logic
	);
end entity ula;

architecture rtl of ula is
	constant OP_ADD : unsigned(1 downto 0) := "00";
	constant OP_SUB : unsigned(1 downto 0) := "01";
	constant OP_DIV : unsigned(1 downto 0) := "10";
	constant OP_XOR : unsigned(1 downto 0) := "11";

	signal a_u : unsigned(19 downto 0) := (others => '0');
	signal b_u : unsigned(19 downto 0) := (others => '0');

	signal add_res : unsigned(19 downto 0) := (others => '0');
	signal sub_res : unsigned(19 downto 0) := (others => '0');
	signal div_res : unsigned(19 downto 0) := (others => '0');
	signal xor_res : unsigned(19 downto 0) := (others => '0');
	signal y_res   : unsigned(19 downto 0) := (others => '0');
begin
	a_u <= unsigned(in_A);
	b_u <= unsigned(in_B);

	add_res <= a_u + b_u;
	sub_res <= a_u - b_u;
	div_res <= a_u / b_u when b_u /= 0 else (others => '0');

	-- XOR bit-wise: (A OR B) AND (NOT (A AND B))
	xor_res <= (in_A or in_B) and (not (in_A and in_B));

	with op select
		y_res <= unsigned(add_res) when OP_ADD,
				 unsigned(sub_res) when OP_SUB,
				 unsigned(div_res) when OP_DIV,
				 xor_res                  when OP_XOR,
				 (others => '0')          when others;

	out_ULA <= y_res;
	zero <= '1' when y_res = (y_res'range => '0') else '0';
	lt   <= '1' when a_u < b_u else '0';
end architecture rtl;