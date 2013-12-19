library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
ENTITY RAMHelper IS
	PORT(
		memAddress: IN std_logic_vector(7 downto 0);
		dipswitch: IN std_logic_vector(7 downto 0);
		pushButton1: IN BIT;
		pushButton2: IN BIT;
		fromRAM: IN std_logic_vector(7 downto 0);
		helpedOutput: OUT std_logic_vector(7 downto 0)
	);
END RAMHelper;

ARCHITECTURE behavior OF RAMHelper IS
 SIGNAL tempHelpedOutput: std_logic_vector(7 downto 0);
BEGIN
PROCESS(memAddress, dipswitch, pushButton1, pushButton2, fromRAM)
BEGIN
	tempHelpedOutput <= (7 downto 0 => '0');
	IF(memAddress(7)='0' AND memAddress(6)='0' AND memAddress(5)='0' AND memAddress(4)='0' AND memAddress(3)='0' AND memAddress(2)='0' AND memAddress(1)='0' AND memAddress(0)='0') THEN
		tempHelpedOutput <= dipswitch;
	ELSIF(memAddress(7)='0' AND memAddress(6)='0' AND memAddress(5)='0' AND memAddress(4)='0' AND memAddress(3)='0' AND memAddress(2)='0' AND memAddress(1)='0' AND memAddress(0)='1') THEN
		tempHelpedOutput(0) <= to_stdulogic(pushButton1);
	ELSIF(memAddress(7)='0' AND memAddress(6)='0' AND memAddress(5)='0' AND memAddress(4)='0' AND memAddress(3)='0' AND memAddress(2)='0' AND memAddress(1)='1' AND memAddress(0)='0') THEN
		tempHelpedOutput(0) <= to_stdulogic(pushButton2);
	ELSE
		tempHelpedOutput <= fromRAM;
	END IF;
END PROCESS;
helpedOutput <= tempHelpedOutput;
END behavior;

