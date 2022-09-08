----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:48:17 07/10/2022 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity ALUMux is
      Port ( Addr1,Addr2,Addr3,Addrx : in STD_LOGIC_VECTOR (2 downto 0);
		       S: in STD_LOGIC_VECTOR (1 downto 0);
		       Addra: out STD_LOGIC_VECTOR (2 downto 0)
		      ); 
end ALUMux;

architecture ALUMODEL of ALUMux is

begin
	process (Addr1,Addr2,Addr3,Addrx,S) is
	begin
		  if (S = "01") then
			Addra <= Addr1;
	  elsif (S = "10") then
			Addra <= Addr2;
	  elsif (S = "11") then
			Addra <= Addr3; 
	  end if;
	end process;


end ALUMODEL;
