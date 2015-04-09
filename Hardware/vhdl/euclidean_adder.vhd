LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
library work;

entity euclidean_adder is
	port(	
		distance0,
	   distance1,
		distance2,
	   distance3,
		distance4,
	   distance5,
		distance6,
	   distance7
	   : in std_logic_vector(31 downto 0);
		sum : out std_logic_vector(31 downto 0)
	);
end euclidean_adder;

architecture behavioural of euclidean_adder is


  type values is array (0 to 7) of unsigned(31 downto 0);
  signal valueArray : values := (others =>(others => '0'));
  signal finalSum : std_LOGIC_VECTOR(31 downto 0) := (others => '0') ;

begin
	process(distance0,
	   distance1,
		distance2,
	   distance3,
		distance4,
	   distance5,
		distance6,
	   distance7)
	begin
		valueArray(0) <= unsigned(distance0);
		valueArray(1) <= unsigned(distance1);
		valueArray(2) <= unsigned(distance2);
		valueArray(3) <= unsigned(distance3);
		valueArray(4) <= unsigned(distance4);
		valueArray(5) <= unsigned(distance5);
		valueArray(6) <= unsigned(distance6);
		valueArray(7) <= unsigned(distance7);
	end process;

	process(valueArray)
	variable sumTemp : unsigned(31 downto 0);
	begin
		sumTemp := (others => '0');
		for i in 0 to 7 loop	
			sumTemp := sumTemp + valueArray(0);
		end loop;
		
		finalSum <= std_LOGIC_VECTOR(sumTemp);
	
	end process;
	
	sum <= finalSum;

end behavioural;