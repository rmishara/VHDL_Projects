----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:25:52 06/30/2022 
-- Design Name: 
-- Module Name:    n_bit_full_adder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity n_bit_full_adder is
generic (N : INTEGER := 8);

    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0);
           B : in  STD_LOGIC_VECTOR(N-1 downto 0);
           Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(N-1 downto 0);
           Cout : out  STD_LOGIC);
end n_bit_full_adder;

architecture Behavioral of n_bit_full_adder is

component FULL_ADDER
	Port ( 
			A : in STD_LOGIC;
			B : in STD_LOGIC;
			Cin : in STD_LOGIC;
			S : out STD_LOGIC;
			Cout : out STD_LOGIC);
	end component;
	
--  Intermediate Carry declaration
signal tcout:  STD_LOGIC_VECTOR (N-1 downto 0); 

begin

gen_add: for i in 0 to N-1 generate

lower_bit: if i=0 generate

		FAU0:FULL_ADDER port map

						( A=>A(i),B=>B(i),Cin=>Cin,S=>S(i),Cout=>tcout(i+1)); -- of LSB bit
												 
	end generate lower_bit;

mid_bit: if i>0 and i<N-1 generate

	FAU1:FULL_ADDER port map 
						( A=>A(i),B=>B(i),Cin=>tcout(i),S=>S(i),Cout=>tcout(i+1)); -- Port map of middle bits

	end generate mid_bit;

upper_bit: if i=N-1 generate

	FAU2:FULL_ADDER port map 
						( A=>A(i),B=>B(i),Cin=>tcout(i),S=>S(i),Cout=>Cout);  --Port map of  MSB

	end generate upper_bit;

end generate gen_add;

end Behavioral;

