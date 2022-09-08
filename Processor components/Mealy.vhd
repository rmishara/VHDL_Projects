----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:48:02 07/11/2022 
-- Design Name: 
-- Module Name:    Mealy - Behavioral 
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

entity ALMcontrolUnit_Mealy is
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
end ALMcontrolUnit_Mealy;

architecture Behavioral of ALMcontrolUnit_Mealy is

	signal mode : STD_LOGIC; -- MODE=1 -> both A and B used operations, MODE=0 -> only A used operations 
	
	type state is (S0, S1, S2);
   signal present_state, next_state : state;

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
	
	-- send opcode to ALU
	op <= opcode;
	
	synchronous_process: process (clk)
	begin

		 if rising_edge(clk) then
			  if (nrst = '0') then
					present_state <= S0;
			  else
					present_state <= next_state;
			  end if;
		 end if;

	end process;


	next_state_and_output_decoder : process(present_state, enb, mode)
    begin
    case (present_state) is 
    when S0 =>
        if (enb = '1' and mode = '1') then
            next_state <= S1;
            wea <= "0";
            smux <= "01";
            tRegOut <= '1';
        elsif (enb = '1' and mode = '0') then
            wea <= "0";
            smux <= "11";

        elsif(enb = '0') then
            next_state <= S0;
        end if;    
    when S1 =>
        wea <= "0";
        smux <= "10";
		  tRegOut <= '0';
    when S2 =>
        wea <= "1";
        smux <= "11";

    
    end case;
    end process;

end Behavioral;