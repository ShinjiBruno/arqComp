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

    with a3 select
        we(0) <= we3 when "000", '0' when others;
    with a3 select
        we(1) <= we3 when "001", '0' when others;
    with a3 select
        we(2) <= we3 when "010", '0' when others;
    with a3 select
        we(3) <= we3 when "011", '0' when others;
    with a3 select
        we(4) <= we3 when "100", '0' when others;
    with a3 select
        we(5) <= we3 when "101", '0' when others;
    with a3 select
        we(6) <= we3 when "110", '0' when others;
    with a3 select
        we(7) <= we3 when "111", '0' when others;

    -- REGISTRADOR 0 (sempre zero)
    r0 <= (others => '0');

    -- DECODER (3 -> 8)
    reg1: Eq12_reg20bits port map(clk, rst, we(1), wd3, r1);
    reg2: Eq12_reg20bits port map(clk, rst, we(2), wd3, r2);
    reg3: Eq12_reg20bits port map(clk, rst, we(3), wd3, r3);
    reg4: Eq12_reg20bits port map(clk, rst, we(4), wd3, r4);
    reg5: Eq12_reg20bits port map(clk, rst, we(5), wd3, r5);
    reg6: Eq12_reg20bits port map(clk, rst, we(6), wd3, r6);
    reg7: Eq12_reg20bits port map(clk, rst, we(7), wd3, r7);

    with a1 select
        rd1 <= r0 when "000",
                r1 when "001",
                r2 when "010",
                r3 when "011",
                r4 when "100",
                r5 when "101",
                r6 when "110",
                r7 when "111",
                "00000000000000000000" when others;
    
    with a2 select
        rd2 <= r0 when "000",
                r1 when "001",
                r2 when "010",
                r3 when "011",
                r4 when "100",
                r5 when "101",
                r6 when "110",
                r7 when "111",
                "00000000000000000000" when others;

end a_Eq12_RegFile;