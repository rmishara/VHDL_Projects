----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:01:01 07/01/2022 
-- Design Name: 
-- Module Name:    Rshift_top_TB - Behavioral 
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

entity Rshift_top_TB is
end Rshift_top_TB;

ARCHITECTURE behavior OF Rshift_top_TB IS

    COMPONENT Rshift_top_model

    PORT(

         clk : IN  std_logic;
         sp : IN  std_logic;
         enb : IN  std_logic;
         resetn : IN  std_logic;
         Dsin : IN  std_logic;
         Dpin : IN  std_logic_vector(3 downto 0);
         Qout : OUT  std_logic_vector(3 downto 0)
        );

    END COMPONENT;

   --Inputs

   signal clk : std_logic := '0';
   signal sp : std_logic := '0';
   signal enb : std_logic := '0';
   signal resetn : std_logic := '0';
   signal Dsin : std_logic := '0';
   signal Dpin : std_logic_vector(3 downto 0) := (others => '0');

   --Outputs

   signal Qout : std_logic_vector(3 downto 0);

   -- Clock period definitions

   constant clk_period : time := 100 ns;

 

BEGIN
      -- Instantiate the Unit Under Test (UUT)

   uut: Rshift_top_model PORT MAP (

          clk => clk,
          sp => sp,
          enb => enb,
          resetn => resetn,
          Dsin => Dsin,
          Dpin => Dpin,
          Qout => Qout

        );

 

   -- Clock process definitions

   clk_process :process

   begin

                        clk <= '0';
                        wait for clk_period/2;
                        clk <= '1';
                        wait for clk_period/2;

   end process;

   -- Stimulus process

   stim_proc: process
   begin                       

   -- hold reset state for 100 ns.

      wait for 100 ns;    
		wait for clk_period; 

   -- insert stimulus here

   enb <='1';
   resetn<='1';
   sp<='1';
   dpin<="1100";

            dsin<='0';
            wait for clk_period;
            enb <='1';

   resetn<='0';

            wait for clk_period;
            enb <='1';

   resetn<='1';

            wait for clk_period;
            enb <='0';

   resetn<='1';  
	
            wait for clk_period;
            sp<='0';
            enb <='1';
            wait for clk_period;
            sp<='0';
            enb <='1';

   resetn<='0';  

            wait for clk_period;
            sp<='1';
            enb <='1';

   resetn<='1';  
      wait for clk_period;
            sp<='0';
            wait for clk_period;
            wait for clk_period;
            enb <='0';
      wait;

   end process;

 

END;
