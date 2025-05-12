library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stack is
    Port ( clk : in  STD_LOGIC;
          rst : in  STD_LOGIC;
          push : in  STD_LOGIC;
          pop : in  STD_LOGIC;
          peek : in	STD_LOGIc;
          data_in : in  STD_LOGIC_VECTOR (3 downto 0);
          --Entradas
			    data_out : out  STD_LOGIC_VECTOR (3 downto 0);
          empty : out  STD_LOGIC;	--Vacia
          full : out	STD_LOGIC	--Llena
			    --Salidas
			  );
end stack;

--Pila de 8 lugares con capacidad de 4 bits
architecture Behavioral of stack is
    type stack_array is array (0 to 7) of std_logic_vector(3 downto 0);  --Llenar la pila de 0's
	 signal stack : stack_array := (others => (others => '0'));
    signal sp : integer range 0 to 8 := 0;  -- APUNTADOR
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

    process(clk, rst)
    begin
        if rst = '1' then
            sp <= 0;
            stack <= (others => (others => '0'));

        elsif rising_edge(reloj) then

            -- PUSH
            if (push = '1') and (sp < 8) then
                stack(sp) <= data_in;
					 sp <= sp + 1;

            -- POP
            elsif (pop = '1') and (sp > 0) then
					stack(sp) <= "0000";
               sp <= sp - 1;
            end if;
        end if;
    end process;

	data_out <= stack(sp - 1) when (sp > 0) and (peek = '1') else (others => '0');

    -- Estado de la Stack
    empty <= '1' when sp = 0 else '0'; --Vacia
    full  <= '1' when sp = 8 else '0';	--Llena

end Behavioral;
