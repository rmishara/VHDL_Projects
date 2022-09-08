--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:36:25 07/01/2022
-- Design Name:   
-- Module Name:   E:/Xilinx projects/FULL_ADDER/n_bit_full_adder_TB.vhd
-- Project Name:  FULL_ADDER
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: n_bit_full_adder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY n_bit_full_adder_TB IS
END n_bit_full_adder_TB;
 
ARCHITECTURE behavior OF n_bit_full_adder_TB IS 
 
    COMPONENT n_bit_full_adder
   generic (N : INTEGER := 8);
            Port (
            A : in STD_LOGIC_VECTOR (N-1 downto 0);
            B : in STD_LOGIC_VECTOR (N-1 downto 0);
            Cin : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (N-1 downto 0);
            Cout : out STD_LOGIC);
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal Cout : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	r_add_unit:n_bit_full_adder generic map(N=>4)
   PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          S => S,
          Cout => Cout
        );

   -- Clock process definitions
   stim_process :process
   begin
   -- hold reset state for 100 ns.

wait for 100 ns;
A <= "0110";
B <= "1100";

wait for 100 ns;
A <= "0110";
B <= "1100";
Cin<='1';

wait for 100 ns;
A <= "1111";
B <= "1100";
Cin<='0'; 

wait for 100 ns;
A <= "0110";
B <= "0111";

wait for 100 ns;
A <= "0110";
B <= "1110";

wait for 100 ns;
A <= "1111";
B <= "1111";
      wait;
   end process;

END;
