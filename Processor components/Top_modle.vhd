----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:24:43 07/11/2022 
-- Design Name: 
-- Module Name:    Top_modle - Behavioral 
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
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALM_TopModule is
 generic(C_SIMULATION : string := "TRUE");
 port(
		enb : in STD_LOGIC;
		nrst : in STD_LOGIC;
		opcode : in STD_LOGIC_VECTOR (3 downto 0);
		clk_100MHz : in STD_LOGIC;
		Addr1,Addr2,Addr3,Addrx : in STD_LOGIC_VECTOR (2 downto 0);
		Dout : out STD_LOGIC_VECTOR (7 downto 0)
	);
end ALM_TopModule;

architecture model_ALM of ALM_TopModule is
   signal clk_1Hz : STD_LOGIC;
	signal swea : STD_LOGIC_VECTOR(0 DOWNTO 0); -- signal between CU:wea and BRAM:wea
   signal muxOut_to_addar : STD_LOGIC_VECTOR (2 downto 0); -- signal between MUX:Addra ans BRAM:Addra
	signal CUTo_Mux : STD_LOGIC_VECTOR (1 downto 0); -- signal between CU:smux and MUX:S
	signal cu_to_op : STD_LOGIC_VECTOR (3 downto 0); -- signal between CU_op and ALU_op
	signal sregIn : std_logic; -- Signal between CU:enable_register and t_reg:enable
	signal Data_path : STD_LOGIC_VECTOR(7 DOWNTO 0); -- signal from ALU:douta
	signal Reg_out : STD_LOGIC_VECTOR(7 DOWNTO 0); --signal between ALU:alu_out and T_REG:DOUT
	signal ALU_OUT_VALUE : STD_LOGIC_VECTOR(7 DOWNTO 0); -- signal between BRAM:dina and ALU:alu_out

begin
 
    
child_MUX: entity work.ALUMux port map(
			Addr1 => Addr1,
			Addr2 => Addr2,
			Addr3 => Addr3,
			Addrx => "000",
			S =>CUTo_Mux,
			Addra => muxOut_to_addar );	
			
child_CU: entity work.ALMControlUnit_Mealy port map (
			enb => enb,
			nrst => nrst,
			opcode => opcode,
			clk => clk_1Hz,
			tRegOut => sregIn,
			op => cu_to_op,
			wea => swea,
			smux => CUTo_Mux );
																	
child_REG: entity work.Reg port map (
			DIN => Data_path, 
			DOUT => Reg_out,
			ENABLE => sregIn,
			RESET => '0',
			CLK => clk_1Hz  
			);
			
child_ALU: entity work.ALMALU port map (
			A => Reg_out,
			B => Data_path,
			op => cu_to_op,
			ALU_out => ALU_OUT_VALUE);
				 
child_LMBR: entity work.child_LMBR1 port map(
			clka => clk_1Hz,
			wea => swea,
			addra => muxOut_to_addar,
			dina => ALU_OUT_VALUE,
			douta => Data_path );	
			
DOUT <= Data_path;

-- Clock divider not apply on simulation
	clk_unit:if(C_SIMULATION  /="TRUE") generate
		clock_divider : entity work.clock_div_model 
		port map (
			clkin => clk_100MHz, 
			clkout => clk_1Hz);
	end generate clk_unit;


	--Input clock directly use in simulation as clock input
	non_clk_unit:if(C_SIMULATION  ="TRUE") generate
		clk_1Hz<=clk_100MHz;
	end generate non_clk_unit;
end model_ALM;


