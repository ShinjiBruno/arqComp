-- Autoria: Bruno Shinji

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_maq_estados is 
    port(
        clk: in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;

        o_estado: out std_logic --0: fetch; 1: decode/execute
    );

end entity eq12_maq_estados;

architecture a_eq12_maq_estados of eq12_maq_estados is
    signal s_estado : std_logic := '0';
begin
    process(clk,rst,wr_en)
    begin
        if rst = '1' then
            s_estado <= '0';
        elsif wr_en = '1' then
            if rising_edge(clk) then
                s_estado <= not s_estado;
            end if;
        end if;
    end process;
    o_estado <= s_estado;
end architecture a_eq12_maq_estados;