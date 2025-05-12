library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sumador_4bits is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);  -- Vector entrada A 4 bits
        B     : in  STD_LOGIC_VECTOR(3 downto 0);  -- Vector entrada B 4 bits
        Cin   : in  STD_LOGIC;                     -- Pin para el acarreo de entrada
        S     : out STD_LOGIC_VECTOR(3 downto 0);  -- Vector salida 4 bits
        Cout  : out STD_LOGIC                      -- Pin acarreo de salida
    );
end sumador_4bits;

architecture Behavioral of sumador_4bits is
    signal temp_sum : STD_LOGIC_VECTOR(4 downto 0);  -- Señal para procesar la suma sin desbordamiento 5 bits
begin
    process(A, B, Cin)
    begin
        temp_sum <= ('0' & A) + ('0' & B) + Cin;
        S <= temp_sum(3 downto 0);  -- S = A + B
        Cout <= temp_sum(4);
    end process;
end Behavioral;
