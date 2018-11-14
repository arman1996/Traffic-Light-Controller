----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:04:00 10/17/2018 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
    Port ( 
				-- Pymble (A)
				AL				:	out  	STD_LOGIC_VECTOR (2 downto 0);
				AT				:	out  	STD_LOGIC_VECTOR (2 downto 0);
				AR				:	out  	STD_LOGIC_VECTOR (2 downto 0);
			  
				-- Waste (B)
				BL 			: 	out  	STD_LOGIC_VECTOR (2 downto 0);
				BT 			: 	out  	STD_LOGIC_VECTOR (2 downto 0);
				BR 			: 	out  	STD_LOGIC_VECTOR (2 downto 0);
			  
				-- Ryde (C)
				CT 			:	out  	STD_LOGIC_VECTOR (2 downto 0);
				CR 			:	out  	STD_LOGIC_VECTOR (2 downto 0);
			  
				-- Macquarie (D)
				DT 			: 	out  	STD_LOGIC_VECTOR (2 downto 0);
				DR 			: 	out  	STD_LOGIC_VECTOR (2 downto 0);
			  
				-- Car Sensors
				AR_Sensor 	: 	in  	STD_LOGIC;
				B_Sensor		: 	in  	STD_LOGIC;
				CR_Sensor	: 	in  	STD_LOGIC;
				D_Sensor		: 	in  	STD_LOGIC;
			  
				-- Pedestrian Crossing Sensors
				-- Pedestrian Crossing Sensors - Pymble
				-- This Fucking Button is ACTIVE LOW!!!
				PCS_A 		: 	in  	STD_LOGIC;
				-- Button Light to indicate whether i am crazy or not!!!
				PB1			:	out	STD_LOGIC;
				-- Boolean Light Indicator.
				Bool			:	out	STD_LOGIC;
				
				-- Pedestrian Crossing Sensors - Waste
				PCS_B 		: 	in  	STD_LOGIC;
				
				-- Pedestrian Crossing Sensors - Ryde
				--PCS_C 		: in  	STD_LOGIC_VECTOR (1 downto 0);
				
				-- Pedestrian Crossing Sensors - Macquarie
				PCS_D 		: 	in  	STD_LOGIC;
				
				
				-- Pedestrian Crossing Lights
				-- Pedestrian Crossing Lights - Pymble
				PCL_A 		: 	out  	STD_LOGIC_VECTOR (1 downto 0);
				
				-- Pedestrian Crossing Lights - Waste
				PCL_B 		: 	out  	STD_LOGIC_VECTOR (1 downto 0);
				
				-- Pedestrian Crossing Lights - Ryde
				--PCL_C 		: out  	STD_LOGIC (1 downto 0);
				
				-- Pedestrian Crossing Lights - Macquarie
				PCL_D 		: 	out  	STD_LOGIC_VECTOR (1 downto 0);
				
				-- Pedestrian Crossing Sounds
				-- Pedestrian Crossing Buzzer
				PC_Buzz 	: 	out  	STD_LOGIC;
				
				-- Clock
				Clock			: 	in  	STD_LOGIC;
				
				-- Reset
				RST			:	in		STD_LOGIC);
				
end Controller;

architecture Behavioral of Controller is

-- TRY AND GET RID OF MS.
component Clock_Manager is
Port(
		CLK:	in STD_LOGIC;
		MS: 	out STD_LOGIC;
		S: 	out STD_LOGIC
		);
end component;

-- Define States
	type state is (X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, X4, Y4, Z4, X5, Y5, Z5, X6, Y6, Z6);
	signal currentST : state;
	
	signal ONE_S_CLK	:	STD_LOGIC;

--signal
	signal countTemp	:  integer;
	
	signal PCS_A_Flag	:	STD_LOGIC;
	signal beenInFlowOne : boolean;
	
begin

	-- Mapping Ports of Clock Manager to Clock of Controller.
	Clock_Instance	: Clock_Manager port map(CLK=>Clock, S=>ONE_S_CLK);
	
	--state	:	X1;
	
	process(ONE_S_CLK)
		-- Counter
		variable count	:	integer range 0 to 30;
	
	begin
		if RST = '1' then
			-- In Reset Mode, All Traffic Lights Must Be Red.
			AL		<=		"100";
			AT		<=		"100";
			AR		<=		"100";
			BL		<=		"100";
			BT		<=		"100";
			BR		<=		"100";
			CT		<=		"100";
			CR		<=		"100";
			DT		<=		"100";
			DR		<=		"100";
			
			-- In Reset Mode, All Pedestrian Lights Must Be Red.
			-- 01 = Red
			-- 10 = Green
			-- 11 = Orange (both are on)
			PCL_A		<=		"01"; -- Red
			PCL_B		<=		"01"; -- Red
			PCL_D 	<=		"01"; -- Red
			
			PB1		<=		'0';	-- Waiting Pedestrian at A Indicator Light.
			PCS_A_Flag <=	'0';	-- Initialization.
			
			beenInFlowOne <= false;
			Bool	<=		'0';		-- For Debugging.
			
			-- Pedestrian Buzzer is 0.
			PC_Buzz <= '0';
			
			currentST <= X1;
			count := 0;
			
		elsif (ONE_S_CLK'event and ONE_S_CLK = '1' and RST = '0') then
			case currentST is
				-- When in Flow One Green State.
				when X1 =>
					if (count < 20) then
						-- Green for 19s
						AL		<=		"001";
						AT		<=		"001";
						AR		<=		"100";
						BL		<=		"100";
						BT		<=		"100";
						BR		<=		"100";
						CT		<=		"001";
						CR		<=		"100";
						DT		<=		"100";
						DR		<=		"100";
						-- Pedestrian Sound Operation.
						if (count < 10) then
							if(count rem 2 = 0) then
								PC_Buzz <= '1';
							else
								PC_Buzz <= '0';
							end if;
						elsif (count >= 10 and count < 18) then
							if(count rem 4 = 0) then
								PC_Buzz <= '1';
							else
								PC_Buzz <= '0';
							end if;
						end if;
						-- Pedestrian Light Operation.
						if (count < 10) then
							PCL_B		<=		"10"; -- Ped B Goes Green
							PCL_D		<=		"10"; -- Ped D Goes Green
						elsif (count >= 10 and count < 18) then
							if (count rem 2 = 0) then
								PCL_B		<=		"00"; -- Ped A Goes Off
								PCL_D		<=		"00"; -- Ped A Goes Off
							else
								PCL_B		<=		"01"; -- Ped A Goes Red
								PCL_D		<=		"01"; -- Ped A Goes Red
							end if;
						else
							PCL_B		<=		"01"; -- Ped B Goes Red
							PCL_D		<=		"01"; -- Ped D Goes Red
						end if;
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Count.
						count := (count + 1);
					elsif (count = 20 and beenInFlowOne = true and PCS_A_Flag = '1') then
						count := 0;
						currentST <= Y1;
						PC_Buzz <= '0';
						--Bool <= '1';
					-- Check if all sensors are off, stay in green.
					elsif (count = 20 and CR_Sensor = '0' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
						-- If no Car Sensors are triggered and Pedestrian Corssing is triggered.
						if (PCS_A_Flag = '1') then
							count := 0;
							currentST <= Y1;
							PC_Buzz <= '0';
						-- If not, stay green.
						else
							beenInFlowOne <= true;
							--Bool <= '1';
							count	:= 0;
							currentST <= X1;
							PC_Buzz <= '0';
						end if;
					elsif (count = 20 or CR_Sensor = '1' or AR_Sensor = '1' or B_Sensor = '1' or D_Sensor = '1') then
						-- Count should be reset
						count := 0;
						-- Move to Y1
						currentST <= Y1;
						PC_Buzz <= '0';
					end if;
				
				-- When in Flow One Yellow State.
				when Y1 =>
					if (count < 1) then
						-- If the transition is from Flow 1 to Flow 5, AL and AT stay green.
						if(CR_Sensor = '0' and AR_Sensor = '1' and B_Sensor = '0' and D_Sensor = '0') then
							AL		<=		"001";
							AT		<=		"001";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"010";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						-- If the transistion is from Flow 1 to Flow 6, CT stays green.
						elsif (CR_Sensor = '1' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
							AL		<=		"010";
							AT		<=		"010";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"001";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						-- Else, Show Yellow Lights For Y1
						else
							AL		<=		"010";
							AT		<=		"010";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"010";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						end if;
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Count.
						count := (count + 1);
					elsif (count = 1) then
						-- Yellow for 2s
						count := 0;
						currentST <= Z1;
					end if;
					
				-- When in Flow One Red State.
				when Z1 =>
					if(count < 1) then
						-- Red Lights For Z1.
						-- If the transistion is from Flow 1 to Flow 5 AL and AT stay green.
						if(CR_Sensor = '0' and AR_Sensor = '1' and B_Sensor = '0' and D_Sensor = '0') then
							AL		<=		"001";
							AT		<=		"001";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"010";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						-- If the transistion is from Flow 1 to Flow 6, CT stays green.
						elsif (CR_Sensor = '1' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
							AL		<=		"100";
							AT		<=		"100";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"001";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						else
							AL		<=		"100";
							AT		<=		"100";
							AR		<=		"100";
							BL		<=		"100";
							BT		<=		"100";
							BR		<=		"100";
							CT		<=		"100";
							CR		<=		"100";
							DT		<=		"100";
							DR		<=		"100";
						end if;
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Count.
						count := (count + 1);
					elsif (count = 1) then
						if (beenInFlowOne = true and PCS_A_Flag = '1') then
							currentST <= X2;
							Bool <= '1';
						else
							if (D_Sensor = '1') then
								currentST <= X2;
							elsif (B_Sensor = '1' and D_Sensor = '0') then
								currentST <= X3;
							elsif (CR_Sensor = '1' and AR_Sensor = '1' and B_Sensor = '0' and D_Sensor = '0') then
								currentST <= X4;
							elsif (CR_Sensor = '0' and AR_Sensor = '1' and B_Sensor = '0' and D_Sensor = '0') then
								currentST <= X5;
							elsif (CR_Sensor = '1' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
								currentST <= X6;
							end if;
						end if;
						if (CR_Sensor = '0' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
							-- If no Car Sensors are triggered but Pedestrian Crossing is triggered.
							if (PCS_A_Flag = '1') then
								currentST <= X2;
							else
								currentST <= X1;
								beenInFlowOne <= true;
							end if;
						end if;
						count := 0;
						beenInFlowOne <= true;
					end if;
					
				-- When in Flow Two Green
				when X2 =>
					beenInFlowOne <= false;
					Bool <= '0';
					-- Reset Pedestrian Flag.
					PCS_A_Flag <= '0';
					-- Reset Indicator Light.
					PB1		  <= '0';
					--beenInFlowOne <= false;
					if (count < 7) then
						-- Green For 6s
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"001";
						DR		<= 	"001";
						-- Pedestrian Light Operation.
						if (count < 3) then
							PCL_A		<=		"10"; -- Ped A Goes Green
						end if;
						if (count >= 3) then
							if (count rem 2 = 0) then
								PCL_A		<=		"00"; -- Ped A Goes Off
							else
								PCL_A		<=		"01"; -- Ped A Goes Red
							end if;
						end if;
						-- Increment Counter
						count := (count + 1);
						
					elsif (count = 7) then
						PCL_A	<=	"01";
						-- Goto Yellow Always.
						count := 0;
						currentST <= Y2;
					end if;
				
				-- When in Flow Two Yellow
				when Y2 =>
					if (count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"010";
						DR		<= 	"010";
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						-- Goto red Always.
						count := 0;
						currentST <= Z2;
					end if;
				
				-- When in Flow Two Red
				when Z2 =>
					if (count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						if (CR_Sensor = '0' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '0') then
							currentST <= X1;
						elsif (CR_Sensor = '0' and AR_Sensor = '0' and B_Sensor = '0' and D_Sensor = '1') then
							currentST <= X1; -- Might Be Wrong.
						elsif (B_Sensor = '1') then
							currentST <= X3;
						elsif (CR_Sensor = '1' and AR_Sensor = '1' and B_Sensor = '0') then
							currentST <= X4;
						elsif (CR_Sensor = '0' and AR_Sensor = '1' and B_Sensor = '0') then
							currentST <= X5;
						elsif (CR_Sensor = '1' and AR_Sensor = '0' and B_Sensor = '0') then
							currentST <= X6;
						end if;
						count := 0;
					end if;
					
				-- When in Flow Three Green
				when X3 =>
					if (count < 5) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"001";
						BT		<= 	"001";
						BR		<= 	"001";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 5) then
						-- Goto Yellow Always
						count := 0;
						currentST <= Y3;
					end if;
				
				-- When in Flow Three Yellow
				when Y3 =>
					if (count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"010";
						BT		<= 	"010";
						BR		<= 	"010";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						-- Goto Red Always
						count := 0;
						currentSt <= Z3;
					end if;
				
				-- When in Flow Three Red
				when Z3 =>
					if (count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						if (CR_Sensor = '0' and AR_Sensor = '0') then
							currentST <= X1;
						elsif (CR_Sensor = '1' and AR_Sensor = '1') then
							currentST <= X4;
						elsif (CR_Sensor = '0' and AR_Sensor = '1') then
							currentST <= X5;
						elsif (CR_Sensor = '1' and AR_Sensor = '0') then
							currentST <= X6;
						end if;
						count := 0;
					end if;
				
				-- When in Flow Four Green
				when X4 =>
					if (count < 7) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"001";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"001";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment COunter
						count := (count + 1);
					elsif (count = 7) then
						-- Goto Yellow ALways.
						count := 0;
						currentST <= Y4;
					end if;
				
				-- When in Flow Four Yellow
				when Y4 =>
					if ( count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"010";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"010";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						-- Got Red Always.
						count := 0;
						currentST <= Z4;
					end if;
					
				-- When in Flow Four Red
				when Z4 =>
					if (count < 1) then
						AL		<= 	"100";
						AT		<= 	"100";
						AR		<= 	"100";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						if (CR_Sensor = '0' and AR_Sensor = '0') then
							currentST <= X1;
						elsif (CR_Sensor = '1' and AR_Sensor = '1') then
							currentST <= X1;
						elsif (CR_Sensor = '0' and AR_Sensor = '1') then
							currentST <= X5;
						elsif (CR_Sensor = '1' and AR_Sensor = '0') then
							currentST <= X6;
						end if;
						count := 0;
					end if;
					
				-- When in Flow Five Green
				when X5 =>
					if (count < 7) then
						AL		<= 	"001";
						AT		<= 	"001";
						AR		<= 	"001";
						BL		<=		"100";
						BT		<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Pedestrian Light Operation.
						if (count < 3) then
							PCL_B		<=		"10"; -- Ped B Goes Green
						end if;
						if (count >= 3) then
							if (count rem 2 = 0) then
								PCL_B		<=		"00"; -- Ped B Goes Off
							else
								PCL_B		<=		"01"; -- Ped B Goes Red
							end if;
						end if;
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						 --Increment Counter
						count := (count + 1);
					elsif (count = 7) then
						PCL_B	<=	"01";
						-- Goto Yellow Always
						count := 0;
						currentST <= Y5;
					end if;
				
				-- When in Flow Five Yellow
				when Y5 =>
					if (count < 1) then
						AL		<= 	"001";
						AT		<= 	"001";
						AR		<= 	"010";
						BL		<=		"100";
						BT 	<= 	"100";
						BR		<= 	"100";
						CT		<= 	"100";
						CR		<= 	"100";
						DT		<= 	"100";
						DR		<= 	"100";
						-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
						-- Increment Counter
						count := (count + 1);
					elsif (count = 1) then
						-- Goto Red Always
						count := 0;
						currentST <= Z5;
					end if;
					
					
					-- When in Flow Five Red
					when Z5 =>
						if (count < 1) then
							AL		<= 	"001";
							AT		<= 	"001";
							AR		<= 	"100";
							BL		<=		"100";
							BT		<= 	"100";
							BR		<= 	"100";
							CT		<= 	"100";
							CR		<= 	"100";
							DT		<= 	"100";
							DR		<= 	"100";
							-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
							-- Increment Counter
							count := (count + 1);
						elsif (count = 1) then
							if (CR_Sensor = '0') then
								currentST <= X1;
							elsif (CR_Sensor = '1') then
								currentST <= X6;
							end if;
							count := 0;
						end if;
					
					-- When in Flow Six Green
					when X6 =>
						if (count < 7) then
							AL		<= 	"100";
							AT		<= 	"100";
							AR		<= 	"100";
							BL		<=		"100";
							BT		<= 	"100";
							BR		<= 	"100";
							CT		<= 	"001";
							CR		<= 	"001";
							DT		<= 	"100";
							DR		<= 	"100";
							-- Pedestrian Light Operation.
							if (count < 3) then
								PCL_D		<=		"10"; -- Ped B Goes Green
							end if;
							if (count >= 3) then
								if (count rem 2 = 0) then
									PCL_D		<=		"00"; -- Ped B Goes Off
								else
									PCL_D		<=		"01"; -- Ped B Goes Red
								end if;
							end if;
							-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
							-- Increment Counter
							count := (count + 1);
						elsif (count = 7) then
							PCL_D	<=	"01";
							-- Goto Yellow Always
							count := 0;
							currentST <= Y6;
						end if;
						
					-- When in Flow Six Yellow
					when Y6 =>
						if (count < 1) then
							AL		<= 	"100";
							AT		<= 	"100";
							AR		<= 	"100";
							BL		<=		"100";
							BT		<= 	"100";
							BR		<= 	"100";
							CT		<= 	"001";
							CR		<= 	"010";
							DT		<= 	"100";
							DR		<= 	"100";
							-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
							-- Increment Counter
							count := (count + 1);
						elsif (count = 1) then
							-- Goto Yellow Always
							count := 0;
							currentST <= Z6;
						end if;
						
					-- When in Flow Six Red
					when Z6 =>
						if (count < 1) then
							AL		<= 	"100";
							AT		<= 	"100";
							AR		<= 	"100";
							BL		<=		"100";
							BT		<= 	"100";
							BR		<= 	"100";
							CT		<= 	"001";
							CR		<= 	"100";
							DT		<= 	"100";
							DR		<= 	"100";
							-- Check for Pedestrian Button for A pressed.
						if (PCS_A = '0') then
							-- Set The Flag.
							PCS_A_Flag	<=	'1';
							-- Indicator Light
							PB1			<=	'1';
						end if;
							-- Increment Counter
							count := (count + 1);
						elsif (count = 1) then
							count := 0;
							currentST <= X1;
						end if;
			end case;
		end if;
		countTemp <= count;
	end process;
end Behavioral;

