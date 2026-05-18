library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_pc_plus1 is
    port(
        instr_in: in unsigned(6 downto 0);

        instr_out: out unsigned(6 downto 0);
    );
end entity;

architecture a_eq12_pc_plus1 of eq12_pc_plus1 is
begin
    instr_out <= instr_in + 1;

end architecture;