----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:30:15 07/10/2022 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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

entity Reg is
 Port ( 
			DIN : in std_logic_vector(7 downto 0);  -- system inputs
			DOUT : out std_logic_vector(7 downto 0);  -- system outputs
			ENABLE : in std_logic;        -- enable
			CLK,RESET : in std_logic);    -- clock and reset
end Reg;

architecture Behavioral of Reg is
signal tmp: std_logic_vector(7 downto 0);

begin

     process(CLK,RESET) 
     begin  -- process
  
         if RESET = '1' then
             DOUT <= "00000000";
         elsif CLK'event and CLK = '1' then
             if ENABLE='1' then
                 tmp <= DIN;
             end if;
             DOUT<=tmp;
         end if;
     end process;
end Behavioral;


