library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_pc_plus1 is
    port(
        address_in: in unsigned(6 downto 0);

        address_out: out unsigned(6 downto 0)
    );
end entity eq12_pc_plus1;

architecture a_eq12_pc_plus1 of eq12_pc_plus1 is
begin
    address_out <= address_in + 1;

end architecture a_eq12_pc_plus1;