library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
ENTITY SetLessThanDetector IS
	PORT(
		overflowFlag: IN BIT;
		signFlag: IN BIT;
		opCode: IN std_logic_vector(3 downto 0);
		aluOutput: IN std_logic_vector(7 downto 0);

		output: OUT std_logic_vector(7 downto 0)
	
	);
END SetLessThanDetector;

ARCHITECTURE behavior OF SetLessThanDetector IS
	SIGNAL tempOutput: std_logic_vector(7 downto 0);
BEGIN
PROCESS(overflowFlag, signFlag, opCode)
BEGIN
	IF(opCode(3)='1' AND opCode(2)='1' AND opCode(1)='1' AND opCode(0)='0' AND (overflowFlag XOR signFlag) = '1') THEN
		tempOutput <= "00000001";
	ElSIF(opCode(3)='1' AND opCode(2)='1' AND opCode(1)='1' AND opCode(0)='0' AND (overflowFlag XOR signFlag) = '0') THEN
		tempOutput <= "00000000";
	ELSE
		tempOutput <= aluOutput;
	END IF;

END PROCESS;
output <= tempOutput;

END behavior;