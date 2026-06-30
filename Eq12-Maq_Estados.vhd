-- Autoria: Bruno Shinji

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq12_maq_estados is 
    port(
        clk: in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;

        o_estado: out unsigned(1 downto 0) --0: fetch; 1: decode; 2: execute; 3: write back
    );

end entity eq12_maq_estados;

architecture a_eq12_maq_estados of eq12_maq_estados is
    signal s_estado : unsigned(1 downto 0) := "00";
    type estados is array (0 to 3) of unsigned(1 downto 0);
    constant c_estados : estados := ("00", "01", "10", "11");
begin
    process(clk,rst,wr_en)
    begin
        if rst = '1' then
            s_estado <= "00";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                if s_estado = "11" then
                    s_estado <= "00";
                else 
                    s_estado <= c_estados(to_integer(s_estado) + 1);
                end if;
            end if;
        end if;
    end process;
    o_estado <= s_estado;
end architecture a_eq12_maq_estados;