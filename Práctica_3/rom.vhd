library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoriaROM is
    Port ( clk : in  STD_LOGIC;
           direccion : in STD_LOGIC_VECTOR (3 downto 0);
			  data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end memoriaROM;

architecture Behavioral of memoriaROM is
	
	type rom_type is array(0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
	
	constant ROM : rom_type := (
        "0010",   -- Dirección 0: 0000
        "1011",   -- Dirección 1: 0001
        "1010",   -- Dirección 2: 0010
        "1000",   -- Dirección 3: 0011
        "0111",   -- Dirección 4: 0100
        "1011",   -- Dirección 5: 0101
        "1100",   -- Dirección 6: 0110
        "1001",   -- Dirección 7: 0111
		  "1010",   -- Dirección 8: 1000
        "1001",   -- Dirección 9: 1001
        "0110",   -- Dirección 10: 1010
        "0010",   -- Dirección 11: 1011
        "0000",   -- Dirección 12: 1100
        "0001",   -- Dirección 13: 1101
        "0011",   -- Dirección 14: 1110
		  "0101"   -- Dirección 15: 1111
    );

	
begin
	
	Frecuencia1Seg: process(clk)
	begin
		if clk'event and clk = '1' then
			Div <= Div + 1;
		end if;
	end process Frecuencia1Seg;
	reloj <= Div(25);

	process(reloj)
	begin
		if rising_edge(reloj) then
			data_out <= ROM(to_integer(unsigned(direccion)));	--Lectura
		end if;
	end process;

	

end Behavioral;
