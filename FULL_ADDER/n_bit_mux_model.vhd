----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:49:53 07/01/2022 
-- Design Name: 
-- Module Name:    n_bit_mux_model - Behavioral 
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

entity n_bit_mux_model is

Port ( 
			a,b,sel : in  STD_LOGIC;
         mout: out std_logic);
			
end n_bit_mux_model;

architecture Behavioral of n_bit_mux_model is

begin
	process(a,b,sel)
	begin
		
		case sel is
			when '0' => mout <= a;
			when '1' => mout <= b;
			when others => mout <= b;
			end case;

	end process;

end Behavioral;

