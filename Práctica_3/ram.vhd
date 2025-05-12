library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoriaRAM is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
           direccion : in STD_LOGIC_VECTOR (3 downto 0);
			  data_in : in  STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end memoriaRAM;

architecture Behavioral of memoriaRAM is
	
	type ram_type is array(0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
	signal RAM : ram_type := (OTHERS => (others => '0'));
	
	signal reloj: std_logic;
	signal Div: std_logic_vector(25 downto 0);
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
			if we = '1' then 
				RAM(to_integer(unsigned(direccion))) <= data_in;
			end if;
			data_out <= RAM(to_integer(unsigned(direccion)));
		end if;
	end process;

	

end Behavioral;
