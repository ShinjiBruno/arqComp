library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity ula_tb;

architecture tb of ula_tb is
    constant CLK_STEP : time := 10 ns;

    constant OP_ADD : std_logic_vector(1 downto 0) := "00";
    constant OP_SUB : std_logic_vector(1 downto 0) := "01";
    constant OP_DIV : std_logic_vector(1 downto 0) := "10";
    constant OP_XOR : std_logic_vector(1 downto 0) := "11";

    signal in_A    : std_logic_vector(19 downto 0) := (others => '0');
    signal in_B    : std_logic_vector(19 downto 0) := (others => '0');
    signal op      : std_logic_vector(1 downto 0) := OP_ADD;
    signal out_ULA : std_logic_vector(19 downto 0);
    signal zero    : std_logic;
    signal lt      : std_logic;
begin
    dut: entity work.ula
        port map (
            in_A    => in_A,
            in_B    => in_B,
            op      => op,
            out_ULA => out_ULA,
            zero    => zero,
            lt      => lt
        );

    stim_proc: process
        variable exp_u : unsigned(19 downto 0);

        -- Exemplo de RAs para o teste de divisao.
        constant RA1_DEC : natural := 2449005;
        constant RA2_DEC : natural := 2017001;

        -- Truncamento decimal para 6 digitos mais significativos (6 MSd):
        -- 2449005 -> 212812 x 10^1
        -- 2017001 -> 201700 x 10^1
        constant RA1_DEC_6MSD : natural := RA1_DEC / 10;
        constant RA2_DEC_6MSD : natural := RA2_DEC / 10;

        --divisao por 4 (2 bits):
        -- 2449005 -> 532030 x 2^2 (resto descartado)
        -- 2017001 -> 504250 x 2^2 (resto descartado)
        constant RA1_BIN_20B : natural := RA1_DEC / 4;
        constant RA2_BIN_20B : natural := RA2_DEC / 4;

        variable ra_maior : natural;
        variable ra_menor : natural;
    begin
        -- Soma: resultado diferente de zero e LT=1 (A < B)
        in_A <= std_logic_vector(to_unsigned(25, 20));
        in_B <= std_logic_vector(to_unsigned(17, 20));
        op <= OP_ADD;
        wait for CLK_STEP;

        -- Subtracao: resultado zero e LT=0 (A == B)
        in_A <= std_logic_vector(to_unsigned(12345, 20));
        in_B <= std_logic_vector(to_unsigned(12345, 20));
        op <= OP_SUB;
        wait for CLK_STEP;

        -- XOR: usa expressao (A OR B) AND NOT(A AND B)
        in_A <= std_logic_vector(to_unsigned(16#AAAA#, 20));
        in_B <= std_logic_vector(to_unsigned(16#5555#, 20));
        op <= OP_XOR;
        wait for CLK_STEP;

        -- Divisao inteira: caso geral
        in_A <= std_logic_vector(to_unsigned(1000, 20));
        in_B <= std_logic_vector(to_unsigned(64, 20));
        op <= OP_DIV;
        wait for CLK_STEP;

        -- Divisao por zero: ULA retorna 0 por protecao
        in_A <= std_logic_vector(to_unsigned(34567, 20));
        in_B <= std_logic_vector(to_unsigned(0, 20));
        op <= OP_DIV;
        wait for CLK_STEP;

        -- Caso pedido: divisao entre RAs da equipe (maior pelo menor), truncados em 20 bits
        -- Valor usado no circuito: truncamento binario (RA/4) para caber em 20 bits.
        if RA1_BIN_20B >= RA2_BIN_20B then
            ra_maior := RA1_BIN_20B;
            ra_menor := RA2_BIN_20B;
        else
            ra_maior := RA2_BIN_20B;
            ra_menor := RA1_BIN_20B;
        end if;

        in_A <= std_logic_vector(to_unsigned(ra_maior, 20));
        in_B <= std_logic_vector(to_unsigned(ra_menor, 20));
        op <= OP_DIV;
        wait for CLK_STEP;

        wait;
    end process;
end architecture tb;
