--------------------------------------------------------------------------------
-- Company: 	Department of Electronic Engineering, Macquarie University
-- Author:	Yimin Xie
-- Create Date: 09:14:07 10/10/06    
-- Module Name: Clock_Manager - Behavioral
-- Revision 0.01 - File Created
-- This module provides two clock frequencies: 1 kHz and 1 Hz.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clock_Manager is
Port(
		CLK:	in STD_LOGIC;
		MS: 	out STD_LOGIC;
		S: 	out STD_LOGIC
		);
end Clock_Manager;

architecture Behavioral of Clock_Manager is
	Signal ms_state, s_state: STD_LOGIC := '0';
		
begin
	process(CLK)
	variable ms_count: integer range 0 to 25000 := 0;	-- Count for ns.
	variable s_count:  integer range 0 to 1000 := 0; 	-- Count for ms.
	
	begin
	  	if (CLK = '1' and CLK'event) then
			if (ms_count < 25000) then ms_count := ms_count + 1;
			else ms_count := 0;
			
			if (s_count < 1000) then s_count := s_count + 1;
			else s_count := 0;
				s_state <= not(s_state);
				S <= s_state; 				-- Output 1 Hz;
			end if;
		
			ms_state <= not(ms_state);
			MS <= ms_state;					-- Output 1 kHz.
			end if;
		end if;
	end  process;
end Behavioral;