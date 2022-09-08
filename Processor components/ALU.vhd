----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:54:46 07/10/2022 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use ieee.NUMERIC_STD.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all


entity ALMALU is
	generic (N : INTEGER := 8);
		Port (
				A : in STD_LOGIC_VECTOR (N-1 downto 0);
				B : in STD_LOGIC_VECTOR (N-1 downto 0);
				op : in STD_LOGIC_VECTOR (3 downto 0); -- Operation code
				Carryout : out std_logic ;             -- Carryout flag
				ALU_out : out STD_LOGIC_VECTOR (N-1 downto 0));	
				
				
end ALMALU;				
architecture arch_ALMALU of ALMALU is
	
signal ALU_Result : std_logic_vector (N-1 downto 0);
signal tmp: std_logic_vector (N downto 0);

begin
	process(A, B, op)
	begin
	case op is
		 when "0000" =>
			ALU_Result <= A+B;                                 --Addition
		when "0001" =>
			ALU_Result <= A - B ;                              --Subtraction
		when "0010" =>
			ALU_Result <= std_logic_vector(unsigned(A) sll 1); --Logical shifted left by 1
		when "0011" =>
			ALU_Result <= std_logic_vector(unsigned(A) srl 1); --logical shifted right by 1
		when "0100" =>
			if(A>B) then -- Greater than
				ALU_Result <= x"01" ;
			else
				ALU_Result <= x"00" ;
			end if;
		when "0101" =>
			if(A=B) then --Equal
				ALU_Result <= x"01" ;
			else
				ALU_Result <= x"00" ;
			end if;
		when "0110" =>
			ALU_Result <= A and B ; -- Bit wise And
		when "0111" =>
			ALU_Result <= A or B ; --Bit wise OR
		when "1000" =>
			ALU_Result <= A XNOR B ; -- Bit wise NOT
		when "1001" =>
			ALU_Result <= A + 1 ; -- Increment by 1
		when "1010" =>
			ALU_Result <= A - 1 ; --Decrement by 1
		when others => ALU_Result <= A + B ;
			NULL;
		end case;
	end process; 
	
	ALU_Out <= ALU_Result; -- ALU out
	tmp <= ('0' & A) + ('0' & B);
	Carryout <= tmp(8); -- Carryout flag

end arch_ALMALU;