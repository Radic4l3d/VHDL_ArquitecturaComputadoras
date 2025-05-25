library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_mp is
    Port (
        clk      : in  STD_LOGIC;
        we       : in  STD_LOGIC;
        addr_w   : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dirección de escritura
        data_in  : in  STD_LOGIC_VECTOR(2 downto 0);  -- Dato de entrada
		  rst : in  STD_LOGIC;
			
        addr_r1  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dirección lectura 1
        data_r1  : out STD_LOGIC_VECTOR(2 downto 0);  -- Dato salida 1

        addr_r2  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dirección lectura 2
        data_r2  : out STD_LOGIC_VECTOR(2 downto 0)   -- Dato salida 2
    );
end ram_mp;

architecture Behavioral of ram_mp is
    type ram_type is array (0 to 3) of STD_LOGIC_VECTOR(2 downto 0); -- 4x4 RAM
    signal RAM : ram_type := (others => (others => '0'));
    signal reg_r1, reg_r2 : STD_LOGIC_VECTOR(2 downto 0);
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

    process(reloj, rst)
    begin
			if rst = '1' then
            RAM <= (others => (others => '0'));
        elsif rising_edge(reloj) then
            -- Escritura
            if we = '1' then
                RAM(to_integer(unsigned(addr_w))) <= data_in;
            end if;

            -- Lecturas
            reg_r1 <= RAM(to_integer(unsigned(addr_r1)));
            reg_r2 <= RAM(to_integer(unsigned(addr_r2)));
        end if;
    end process;

    -- Asignación de salidas registradas
    data_r1 <= reg_r1;
    data_r2 <= reg_r2;

end Behavioral;
