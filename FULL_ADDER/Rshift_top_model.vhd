----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:52:57 07/01/2022 
-- Design Name: 
-- Module Name:    Rshift_top_model - Behavioral 
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

entity Rshift_top_model is
Port( 
		clk: in  STD_LOGIC;
      sp: in  STD_LOGIC; -- select serial/paraller
      enb: in  STD_LOGIC;-- enable
      resetn: in  STD_LOGIC;-- reset when 'low'
      Dsin : in  STD_LOGIC;  -- serial in
      Dpin:in std_logic_vector(3 downto 0); -- parallel in
      Qout: out std_logic_vector(3 downto 0)); --parallel out
end Rshift_top_model;

architecture arch_Rshift_top_model of Rshift_top_model is

	component nbit_mux_model is
		 Port ( 
				a,b,sel : in  STD_LOGIC;
				mout: out std_logic);
	end component nbit_mux_model;

	component lsfit2_model is
		 Port ( 
				clk,nrst,enb,D : in  STD_LOGIC;
				Q,nQ: out std_logic);
	end component lsfit2_model;
	
	signal sQout,snQout,sain,sbin,smout: std_logic_vector(3 downto 0);

	begin
	Rshift_reg_gen: for i in 3 downto 0 generate

	Rshift_reg:lsfit2_model

		Port map ( 
			clk =>clk,
			D=>smout(i),
			nrst=>resetn,
			enb=>enb,
			Q=>sQout(i),
			nQ=> snQout(i));

	mux1:nbit_mux_model

		Port map ( 
			a=>sain(i),
			b=>sbin(i),
			mout=>smout(i),
			sel=>sp);

	-- Daisy-chain D-FF connection
	--Add you code here

	a1: if i=3 generate

		sain(i)<='1';

	end generate a1;
	 
	a2: if i<3 generate

		sain(i)<='0';

	end generate a2;

	end generate Rshift_reg_gen;

	qout<=sQout;
	sbin<=Dpin;

end arch_Rshift_top_model;


