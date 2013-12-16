library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY ProgramCounter IS 
	PORT (
		nextPC: IN std_logic_vector(7 downto 0);
		pcClock: IN BIT;
		outPC: OUT std_logic_vector(7 downto 0)
	);
END ProgramCounter;

ARCHITECTURE behaviour OF ProgramCounter IS 
	SIGNAL tempPC: std_logic_vector(7 downto 0) := (others => '0');
BEGIN
PROCESS(nextPC, pcClock)
BEGIN
	IF (pcClock'EVENT AND pcClock = '1') THEN
		tempPC <= nextPC;
	END IF;
END PROCESS;
	
outPC <= tempPC;
	
END behaviour;