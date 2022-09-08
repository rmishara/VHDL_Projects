--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:43:34 07/01/2022
-- Design Name:   
-- Module Name:   E:/Xilinx projects/FULL_ADDER/Tb_nbit_alu.vhd
-- Project Name:  FULL_ADDER
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nbit_ALU
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;


 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_nbit_alu IS
END Tb_nbit_alu;
 
ARCHITECTURE behavior OF Tb_nbit_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_ALU

 generic (N : INTEGER := 8);

            Port (
            A : in STD_LOGIC_VECTOR (N-1 downto 0);
            B : in STD_LOGIC_VECTOR (N-1 downto 0);
            op : in STD_LOGIC_VECTOR (3 downto 0); -- operation code
            ALU_out : out STD_LOGIC_VECTOR (N-1 downto 0));

 END COMPONENT;
    

   --Inputs
   signal inp_a : signed(3 downto 0) := (others => '0');
	signal inp_b : signed(3 downto 0) := (others => '0');
	signal sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
    signal out_alu : signed(3 downto 0); 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    ALU: nbit_ALU generic map(N=4)

 PORT MAP (

 A => inp_a,
 B => inp_b,
 op => sel,
 ALU_out => out_alu

 );

 

 -- Stimulus process

 stim_proc: process

 begin

 -- hold reset state for 100 ns.

 wait for 100 ns;


 -- insert stimulus here

 inp_a <= "1001";
 inp_b <= "1111";

 sel <= "0000";
 wait for 100 ns;
 sel <= "0001";
 wait for 100 ns;
 sel <= "0010";
 wait for 100 ns;
 sel <= "0011";
 wait for 100 ns;
 sel <= "0100";
 wait for 100 ns;
 sel <= "0101";
 wait for 100 ns;
 sel <= "0110";
 wait for 100 ns;
 sel <= "0111";
 wait for 100 ns;
 sel <= "1000";
 wait for 100 ns;
 sel <= "1001";
 wait for 100 ns;
 sel <= "1010";
 end process;
 
END;
