library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.math_complex.all;
library std;
use std.textio.all;
 
library work;
-------------------------------------------------------------------------------
 
entity euclidean_adder_avalon_interface is
 PORT ( clk, rst_n : IN STD_LOGIC;
	read_en, write_en : IN STD_LOGIC;
	writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	address : IN STD_LOGIC_VECTOR(3 DOWNTO 0)	
	);
end euclidean_adder_avalon_interface;
 
-------------------------------------------------------------------------------
 
architecture interface of euclidean_adder_avalon_interface is

 
  
  
	component euclidean_adder is
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
end component;
  
  signal sum0,sum1,sum2,sum3,sum4,sum5,sum6,sum7 : std_LOGIC_VECTOR(31 downto 0) := (others => '0');
  signal finalSum :std_LOGIC_VECTOR(31 downto 0) := (others => '0') ;
 
  
  
  begin
  
  adder : euclidean_adder port map(
			distance0 => sum0,
	      distance1 => sum1,
		   distance2 => sum2,
	      distance3 => sum3,
		   distance4 => sum4,
	      distance5 => sum5,
			distance6 => sum6,
			distance7 => sum7,	   
			sum => finalSum
		);
	
	
	-- purpose: synchronization of reset
	process (clk, rst_n)
	begin  -- process
	 
    if rst_n = '0' then                 -- asynchronous reset (active low)
		readdata <= (others => '0');
		sum0 <= (others => '0');
		sum1 <= (others => '0');
		sum2 <= (others => '0');
		sum3 <= (others => '0');
		sum4 <= (others => '0');
		sum5 <= (others => '0');
		sum6 <= (others => '0');
		sum7 <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge   
		readdata <= (others => '-');	
		if( write_en = '1' ) then
			case address is
				--Reset			
				when "0000" =>					
					sum0 <= writedata(31 downto 0);				
				when "0001" =>
					sum1 <= writedata(31 downto 0);
				when "0010" =>
					sum2 <= writedata(31 downto 0);
				when "0011" =>
					sum3 <= writedata(31 downto 0);
				when "0100" =>
					sum4 <= writedata(31 downto 0);
				when "0101" =>
					sum5 <= writedata(31 downto 0);
				when "0110" =>
					sum6 <= writedata(31 downto 0);
				when "0111" =>
					sum7 <= writedata(31 downto 0);
				when "1111" =>				
					readdata <= (others => '0');
					sum0 <= (others => '0');
					sum1 <= (others => '0');
					sum2 <= (others => '0');
					sum3 <= (others => '0');
					sum4 <= (others => '0');
					sum5 <= (others => '0');
					sum6 <= (others => '0');
					sum7 <= (others => '0');
				when others => null;
			end case;
					
		elsif( read_en = '1') then	
		
			case address is						
				when "0000" =>					
					readdata <= finalSum;				
				when others => null;	
				
			end case;		
		end if;
	 end if;
	 
	
	end process;
		
end interface;								
					
					
					
				
					
		
	 
	