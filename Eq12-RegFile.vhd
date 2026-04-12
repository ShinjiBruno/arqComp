library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_RegFile is
    port(
        clk, rst, we3 : in std_logic;

        -- Escrita
        wd3 : in unsigned(19 downto 0);
        a3 : in std_logic_vector(2 downto 0);

        -- Leitura
        a1 : in std_logic_vector(2 downto 0);
        a2 : in std_logic_vector(2 downto 0);
        rd1 : out unsigned(19 downto 0);
        rd2 : out unsigned(19 downto 0)
    );
end Eq12_RegFile;

architecture a_Eq12_RegFile of Eq12_RegFile is

    component Eq12_reg20bits
        port(
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(19 downto 0);
            data_out : out unsigned(19 downto 0)
        );
    end component;

    -- Sinais internos
    signal r0, r1, r2, r3, r4, r5, r6, r7 : unsigned(19 downto 0);
    signal we : std_logic_vector(7 downto 0);

begin

    -- REGISTRADOR 0 (sempre zero)
    r0 <= (others => '0');

    -- DECODER (3 -> 8)
    process(a3, we3)
    begin
        we <= (others => '0');

        if we3 = '1' then
            case a3 is
                when "000" => we(0) <= '1';
                when "001" => we(1) <= '1';
                when "010" => we(2) <= '1';
                when "011" => we(3) <= '1';
                when "100" => we(4) <= '1';
                when "101" => we(5) <= '1';
                when "110" => we(6) <= '1';
                when "111" => we(7) <= '1';
                when others => null;
            end case;
        end if;
    end process;

    reg1: Eq12_reg20bits port map(clk, rst, we(1), wd3, r1);
    reg2: Eq12_reg20bits port map(clk, rst, we(2), wd3, r2);
    reg3: Eq12_reg20bits port map(clk, rst, we(3), wd3, r3);
    reg4: Eq12_reg20bits port map(clk, rst, we(4), wd3, r4);
    reg5: Eq12_reg20bits port map(clk, rst, we(5), wd3, r5);
    reg6: Eq12_reg20bits port map(clk, rst, we(6), wd3, r6);
    reg7: Eq12_reg20bits port map(clk, rst, we(7), wd3, r7);

    -- MUX DE LEITURA 1
    process(a1, r0, r1, r2, r3, r4, r5, r6, r7)
    begin
        case a1 is
            when "000" => rd1 <= r0;
            when "001" => rd1 <= r1;
            when "010" => rd1 <= r2;
            when "011" => rd1 <= r3;
            when "100" => rd1 <= r4;
            when "101" => rd1 <= r5;
            when "110" => rd1 <= r6;
            when "111" => rd1 <= r7;
            when others => rd1 <= (others => '0');
        end case;
    end process;

    -- MUX DE LEITURA 2
    process(a2, r0, r1, r2, r3, r4, r5, r6, r7)
    begin
        case a2 is
            when "000" => rd2 <= r0;
            when "001" => rd2 <= r1;
            when "010" => rd2 <= r2;
            when "011" => rd2 <= r3;
            when "100" => rd2 <= r4;
            when "101" => rd2 <= r5;
            when "110" => rd2 <= r6;
            when "111" => rd2 <= r7;
            when others => rd2 <= (others => '0');
        end case;
    end process;

end a_Eq12_RegFile;