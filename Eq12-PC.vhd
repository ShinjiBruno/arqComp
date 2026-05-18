library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_pc is
    port(
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        instr_in : in unsigned(6 downto 0); -- 128 enderecos
        instr_out : out unsigned(6 downto 0); 
end entity;

architecture a_eq12_pc of eq12_pc is
    signal registro : unsigned(6 downto 0);
begin
    process(clk,rst,wr_en)
    begin
        if rst = '1' then
            registro <= "0000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                registro <= instr_in;
            end if;
        end if;
    end process;
    instr_out <= registro;


end architecture;