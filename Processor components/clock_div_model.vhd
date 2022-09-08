----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:05:21 07/11/2022 
-- Design Name: 
-- Module Name:    clock_div_model - Behavioral 
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

entity clock_div_model is
	Port ( clkin : in  STD_LOGIC;
          clkout : out  STD_LOGIC);
end clock_div_model;

architecture Behavioral of clock_div_model is

	constant TIMECONST : integer := 84;
	signal count0, count1, count2, count3 : integer range 0 to 1000;
	signal D : std_logic := '0';

begin
process (ClKIN, D)
begin
		if (ClKIN'event and ClKIN = '1') then
						count0 <= count0 + 1;
					if count0 = TIMECONST then
											count0 <= 0;
											count1 <= count1 + 1;
                        elsif count1 = TIMECONST then
											count1 <= 0;
											count2 <= count2 + 1;
                        elsif count2 = TIMECONST then
											count2 <= 0;
											count3 <= count3 + 1;
                        elsif count3 = TIMECONST then
											count3 <= 0;
                                D <= not D;
                        end if;
            end if;
            ClKOUT <= D;
end process;

end Behavioral;

