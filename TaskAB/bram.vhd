----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:28:24 07/11/2022 
-- Design Name: 
-- Module Name:    bram - Behavioral 
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

entity bram_Top2 is
generic(C_SIMULATION :  string  := "TRUE");
    Port ( din : in  STD_LOGIC_vector(7 downto 0);
            addr: in  STD_LOGIC_vector(2 downto 0);
            nrst:in std_logic;
            enb:in std_logic;
            op:in std_logic;
            clr:in std_logic;
            done:out std_logic;
            clk_100MHz:in std_logic;
            dout : out  STD_LOGIC_vector(7 downto 0)
             );
end bram_Top2;

architecture Behavioral of bram_Top2 is

	component clock_div_model is
		Port ( 
			clkin : in  STD_LOGIC;
			clkout : out  STD_LOGIC);
	end component clock_div_model;

	COMPONENT mbram_model
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	COMPONENT bram_FSM is
      Port ( 
				nrst : in  STD_LOGIC;
            clk:in std_logic;
            enb:in std_logic;
            clr: in std_logic;
            op: in std_logic;
            done: out std_logic;
            mx: out std_logic;
            wea: out std_logic);
   end COMPONENT bram_FSM;
	
	signal clk_1Hz : STD_LOGIC;

   signal smux_out : STD_LOGIC_VECTOR (7 downto 0);
   signal swea : STD_LOGIC_VECTOR(0 DOWNTO 0) := "0"; 
   signal mx: std_logic;

begin

		--2-1  muxltiplexer
		smux_out<=din when mx='0' else x"00";

		--declaration FSM unit 
      CU: bram_FSM
            Port map( 
						nrst =>nrst,
                  clk=>clk_1Hz,
                  enb=>enb,
                  clr=>clr,
                  op=>op,
                  done=>done,
                  mx=>mx,
                  wea=>swea(0));
						
		bram : mbram_model 
				port map (
						clka => clk_1Hz, -- clock for writing data to RAM
						wea => swea, -- write enable signal for Port A
						addra => addr, -- 3 bit address for the RAM
						dina => smux_out, -- 8 bit data input to the RAM
						douta => dout); --8 bit data output to the RAM 
						
		-- Clock divider not apply on simulation
		clk_unit:if(C_SIMULATION  /="TRUE") generate
			clock_divider : clock_div_model 
			port map (ClKIN => clk_100MHz, ClKOUT => clk_1Hz);
		end generate clk_unit;


		--Input clock directly use in simulation as clock input
		non_clk_unit:if(C_SIMULATION  ="TRUE") generate
			clk_1Hz<=clk_100MHz;
		end generate non_clk_unit;


end Behavioral;