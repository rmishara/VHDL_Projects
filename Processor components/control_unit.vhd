----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:33:04 07/11/2022 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
	Port ( 
			nrst : in  STD_LOGIC;
         clk:in std_logic;
         enb:in std_logic;
			opcode  : in STD_LOGIC_vector(7 downto 0);
         op: in STD_LOGIC_VECTOR(7 downto 0);
         done: out STD_LOGIC_vector(0 downto 0);
         mx: out std_logic;
         wea: out std_logic);
			
end control_unit;

architecture Behavioral of control_unit is
	type state is (Idle, Decode, Clear, Mwrite, DoneState);
   signal present_state, next_state : state;
begin
	synchronous_process: process (clk)
	begin
		 if rising_edge(clk) then
			  if (nrst = '0') then
					present_state <= Idle;
			  else
					present_state <= next_state;
			  end if;
		 end if;

	end process;

	output_decoder : process(present_state, nrst, enb, opcode, op)
	begin
    next_state <= Idle; case (present_state) is 	 
		
		when Idle =>
	        if (enb = '0') then
	            next_state <= Idle;
	        elsif (enb = '1') then
	            next_state <= Decode;
			  elsif (opcode = "1") then
	            next_state <= Clear; 
			end if; 
		when Decode =>	
	        if (op= "111") then
	            next_state <= Mwrite;
	        else
	            next_state <= DoneState; 
			end if;  
		when Clear =>
	        next_state <= DoneState; 
		when Mwrite =>	
	        next_state <= DoneState; 
		when DoneState =>
		when others =>
			next_state <= Idle; 
		end case; 
		end process; 
		next_state_decoder : process(present_state) 
		begin 
			case (present_state) is 	 
			when Clear =>
            	mx <= '1'; 
					wea <= '1';
			when Mwrite =>
            	wea <= '1'; 
			when DoneState =>
					done <= "1";
			when others =>
            	done <= "0";
			end case;
	end process;

end Behavioral;