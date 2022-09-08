----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:41:57 07/11/2022 
-- Design Name: 
-- Module Name:    bram_FSM - Behavioral 
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

entity ALMControlUnit_Moore is
      	port(
		enb : in STD_LOGIC;
		nrst : in STD_LOGIC;
		opcode : in STD_LOGIC_VECTOR (3 downto 0);
		clk : in STD_LOGIC;
		tRegOut : out STD_LOGIC;
		op : out STD_LOGIC_VECTOR (3 downto 0);
		wea : out STD_LOGIC_VECTOR (0 downto 0);
		smux : out STD_LOGIC_VECTOR 
		);
end ALMControlUnit_Moore;

architecture Behavioral of ALMControlUnit_Moore is
signal mode : STD_LOGIC; -- MODE=1 -> both A and B used operations, MODE=0 -> only A used operations 
	
	type state is (Idle, S0, S1, S2, S3,S4);
   signal present_state, next_state : state;
   signal dout_rom8x8 : STD_LOGIC_VECTOR (7 downto 0);

begin
	-- Check operand is 'mode 0' or 'mode 1'.
	process(opcode, mode)
	begin
	case opcode is
		when "0000" =>
			mode <= '1';
		when "0001" =>
			mode <= '1';
		when "0010" =>
			mode <= '0';
		when "0011" =>
			mode <= '0';
		when "0100" =>
			mode <= '1';
		when "0101" =>
			mode <= '1';
		when "0110" =>
			mode <= '1';
		when "0111" =>
			mode <= '1';
		when "1000" =>
			mode <= '0';
		when "1001" =>
			mode <= '0';
		when "1010" =>
			mode <= '0';
		when others =>
			null;
	end case;
	end process; 
		
		
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

	output_decoder : process(present_state, next_state, mode, enb)
	begin
    next_state <= Idle; case (present_state) is 	 
		when Idle =>
	        if (enb = '0') then
	            next_state <= Idle;
	        elsif (enb = '1') then
	            next_state <= S0; 
			end if; 
		 
		when S0 =>
			if (mode = '1') then
					next_state <= S1;
			else 
					next_state <= S2;
			end if;
		when S1 =>
					next_state <= S2;
	   when S2 =>
					next_state <= S3;
		when S3 =>
				next_state <= S4;			
		when S4 =>
				next_state <= S4;
		when others =>
			---next_state <= Idle; 
		end case; 
		end process; 	


		next_state_decoder : process(present_state) 
		begin 
			
			case (present_state) is
			when Idle =>	
            wea <= "0";
            smux <= "00";
				tRegOut <= '1';			
			when S0 =>
        if (enb = '1' and mode = '1') then
          
            wea <= "0";
            smux <= "01";
				tRegOut <= '1';
        elsif (enb = '1' and mode = '0') then
            wea <= "0";
            smux <= "01";
				tRegOut <= '1';
        end if;    		  
    when S1 =>
	   if (enb = '1' and mode = '1') then
        wea <= "0";
        smux <= "10";
		  tRegOut <= '1';  
		 end if; 
    when S2 =>
        wea <= "1"; 
        smux <= "11";
		  tRegOut <= '0';
     when S3 =>
        wea <= "1";
        smux <= "11";
		  tRegOut <= '1';
	when S4 =>
        wea <= "0";
        smux <= "11";
		  tRegOut <= '1';	  
		end case;
				
		end process;


end Behavioral;
